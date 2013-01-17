package bleach
{
	import bleach.event.BleachDefenseEvent;
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.module.loader.MaskLoading;
	import bleach.module.scene.IScene;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.IPixelDirector;
	import pixel.core.PixelDirector;
	import pixel.core.PixelLauncher;
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessageBus;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.asset.PixelLoaderAssetLibrary;

	/**
	 * 场景控制枢纽
	 * 
	 * 
	 **/
	public class BleachDirector extends PixelDirector implements IPixelDirector
	{
		private var _loading:Boolean = false;
		private var _topLayer:Sprite = null;
		private var _contentLayer:Sprite = null;
		public function BleachDirector()
		{
			super();
//			_contentLayer = new Sprite();
//			_topLayer = new Sprite();
//			gameStage.addChild(_contentLayer);
//			gameStage.addChild(_topLayer);
		}
		
		override public function initializer():void
		{
			super.initializer();
			addMessageListener(BleachMessage.BLEACH_WORLD_REDIRECT,directScene);
			
			//Loading消息监听
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_SHOW,loadingShow);
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_HIDE,loadingHide);
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_UPDATE,loadingUpdate);
			configInit();
		}
		
		private var _sceneCache:Dictionary = new Dictionary();
		private var _sceneMap:Dictionary = new Dictionary();
		
		/**
		 * 配置解析
		 * 
		 **/
		private function configInit():void
		{
			var BleachXML:Object = getDefinitionByName("BleachXML");
			if(!BleachXML)
			{
				throw new Error("");
			}
			var config:XML = new XML(new BleachXML());
			trace(config.toString());
			var scenes:XMLList = config.scenes[0].scene;
			
			for each(var sceneNode:XML in scenes)
			{
				var scene:SceneVO = new SceneVO(
					sceneNode.@id,
					sceneNode.@version,
					sceneNode.@url
				);
				
				var libs:XMLList = sceneNode.library;
				
				for each(var lib:XML in libs)
				{
					var library:SceneLinkLibrary = new SceneLinkLibrary(
						lib.@id,
						lib.@version,
						lib.@url,
						lib.@desc
					);
					library.isUIlib = new Boolean(lib.@uilib);
					scene.addLibrary(library);
				}
				
				_sceneMap[scene.id] = scene;
			}
			System.disposeXML(config);
		}
		
		
		private function loadingShow(msg:BleachLoadingMessage):void
		{
			addSceneTop(MaskLoading.instance);
			_loading = true;
		}
		
		private function loadingHide(msg:BleachLoadingMessage):void
		{
			TweenLite.to(MaskLoading.instance,0.5,{
				"alpha" : 0,
				onComplete : hideComplete
			});
		}
		
		private function hideComplete():void
		{
			removeSceneTop(MaskLoading.instance);
			MaskLoading.instance.alpha = 1;
			_loading = false;
		}
		
		private function loadingUpdate(msg:BleachLoadingMessage):void
		{
			if(_loading)
			{
				MaskLoading.instance.progressUpdate(msg.total,msg.loaded);
			}
		}
		
		/**
		 * 场景切换
		 * 
		 **/
		private function directScene(msg:IPixelMessage):void
		{
			if(_module)
			{
				_module.clear();
			}
			
			var id:String = msg.value as String;
			if(!(id in _sceneCache))
			{
				var profile:SceneVO = _sceneMap[id];
				_module = new SceneModule(profile);
				
				_sceneCache[id] = _module;
			}
			
			_module = _sceneCache[id] as SceneModule;
			if(_module.loaded)
			{
				//已经缓存
				this.swapScene(_module.sceneContent);
			}
			else
			{
				//创建该场景的域
				_module.sceneDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				//_librarys = new Vector.<Loader>();
				_module.library = new Vector.<Loader>();
				_downloaded = 0;
				libraryDownload();
				//显示加载界面
				dispatchMessage(new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_SHOW));
			}
		}
		
		private var _module:SceneModule = null;
		private var _downloaded:int = 0;
		//private var _librarys:Vector.<Loader> = null;
		private var _downloader:Loader = null;
		private var _downlodLinkLibrary:SceneLinkLibrary = null;
		/**
		 * 当前加载场景的链接库下载
		 * 
		 **/
		private function libraryDownload():void
		{
			if(_module)
			{
				if(_downloaded < _module.scene.librarys.length)
				{
					_downlodLinkLibrary = _module.scene.librarys[_downloaded];
					_downloader = new Loader();
					_downloader.contentLoaderInfo.addEventListener(Event.COMPLETE,libraryDownloadComplete);
					_downloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,libraryDownloadError);
					var ctx:LoaderContext = new LoaderContext();
					ctx.applicationDomain = _module.sceneDomain;
					_downloader.load(new URLRequest(_downlodLinkLibrary.url),ctx);
					ctx = null;
				}
				else
				{
					//下载场景主文件
					//sceneDownload();
					_module.clear();
				}
			}
		}
		
		/**
		 * 
		 * 链接库下载完毕
		 * 
		 **/
		private function libraryDownloadComplete(event:Event):void
		{
			_downloader.contentLoaderInfo.removeEventListener(Event.COMPLETE,libraryDownloadComplete);
			_downloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,libraryDownloadError);
			
			_module.library.push(_downloader);
//			if(_downlodLinkLibrary.isUIlib)
//			{
//				//UI库资源
//				PixelAssetManager.instance.addAssetLibrary(new PixelLoaderAssetLibrary(_downloader,_downlodLinkLibrary.id));
//			}
			_downloaded++;
			var updateMsg:BleachLoadingMessage = new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_UPDATE);
			//全部数量为 链接库数量 + 主文件数量
			updateMsg.total = _module.scene.librarys.length + 1;
			updateMsg.loaded = _downloaded;
			dispatchMessage(updateMsg);
			_downloader = null;
			libraryDownload();
		}
		
		private var _sceneLoader:Loader = null;
		/**
		 * 场景主文件下载
		 * 
		 **/
		private function sceneDownload():void
		{
			_sceneLoader = new Loader();
			_sceneLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,sceneDownloadComplete);
			_sceneLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,sceneDownloadError);
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = _module.sceneDomain;
			var url:String = _module.scene.url;
			_sceneLoader.load(new URLRequest(url),ctx);
			
		}
		
		/**
		 * 场景主文件下载完成
		 * 
		 **/
		private function sceneDownloadComplete(event:Event):void
		{
			_sceneLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,sceneDownloadComplete);
			_sceneLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,sceneDownloadError);
			_module.sceneContent = _sceneLoader;
			_sceneLoader = null;
			_downloaded++;
			var updateMsg:BleachLoadingMessage = new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_UPDATE);
			//全部数量为 链接库数量 + 主文件数量
			updateMsg.total = _module.scene.librarys.length + 1;
			updateMsg.loaded = _downloaded;
			dispatchMessage(updateMsg);
			
			this.swapScene(_module.sceneContent.content);
			dispatchMessage(new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_HIDE));
			_module.loaded = true;
			
		}
		private function sceneDownloadError(event:IOErrorEvent):void
		{}
		
		/**
		 * 链接库下载异常
		 * 
		 **/
		private function libraryDownloadError(event:IOErrorEvent):void
		{
			trace("!!!");
		}
		
		
		
		//private var _newScene:DisplayObject = null;
		
		/**
		 * 
		 * 场景切换重写
		 * 这里加入切换效果的支持
		 * 
		 **/
		override protected function swapScene(newScene:DisplayObject):void
		{
			addScene(newScene);
			if(_activedScene)
			{
				//_newScene = newScene;
				//sceneFadeOut(_activedScene);
				removeScene(_activedScene);
				_activedScene = null;
				_activedScene = newScene;
			}
			else
			{
				_activedScene = newScene;
				//sceneFadeIn(_activedScene);
			}
		}
		
//		protected function sceneFadeIn(scene:DisplayObject):void
//		{
//			_activedScene.alpha = 0;
//			TweenLite.to(_activedScene,1,{
//				"alpha" : 1
//			});
//		}
//		
//		protected function sceneFadeOut(scene:DisplayObject):void
//		{
//			_activedScene.alpha = 1;
//			TweenLite.to(_activedScene,0.5,{
//				"alpha" : 0
//			});
//		}
	}
}
import flash.display.Loader;
import flash.display.Scene;
import flash.system.ApplicationDomain;

import pixel.ui.control.asset.PixelAssetManager;

class SceneModule
{
	private var _sceneContent:Loader = null;
	public function set sceneContent(value:Loader):void
	{
		_sceneContent = value;
	}
	public function get sceneContent():Loader
	{
		return _sceneContent;
	}
	private var _loaded:Boolean = false;
	public function get loaded():Boolean
	{
		return _loaded;
	}
	public function set loaded(value:Boolean):void
	{
		_loaded = value;
	}
	private var _domain:ApplicationDomain = null;
	public function get sceneDomain():ApplicationDomain
	{
		return _domain;
	}
	public function set sceneDomain(value:ApplicationDomain):void
	{
		_domain = value;
	}
	private var _scene:SceneVO = null;
	public function get id():String
	{
		return _scene.id;
	}
	
	public function get scene():SceneVO
	{
		return _scene;
	}
	public function SceneModule(scene:SceneVO)
	{
		_scene = scene;
		//_library = new Vector.<Loader>(_scene.librarys.length);
	}
	
	private var _library:Vector.<Loader> = null;
//	public function addLibrary(value:Loader):void
//	{
//		_library.push(value);
//	}
	
	public function set library(value:Vector.<Loader>):void
	{
		_library = value;
		_loaded = true;
	}
	public function get library():Vector.<Loader>
	{
		return _library;
	}
	
	public function clear():void
	{
		var loader:Loader = null;
		for(var idx:int=0; idx<_library.length; idx++)
		{
			loader = _library[idx];
			if(scene.librarys[idx].isUIlib)
			{
				PixelAssetManager.instance.removeAssetLibrary(scene.librarys[idx].id);
				loader = null;
			}
			else
			{
				loader.unloadAndStop();
				loader = null;
			}
		}
		if(_sceneContent)
		{
			_sceneContent.unloadAndStop(true);
			_sceneContent = null;
		}
		_library = null;
		_domain = null;
		_loaded = false;
	}
}

class SceneVO
{
	private var _id:String = "";
	public function set id(value:String):void
	{
		_id = value;
	}
	public function get id():String
	{
		return _id;
	}
	private var _version:String = "";
	public function set version(value:String):void
	{
		_version = value;
	}
	public function get version():String
	{
		return _version;
	}
	private var _url:String = "";
	public function set url(value:String):void
	{
		_url = value;
	}
	public function get url():String
	{
		return _url;
	}
	
	public function SceneVO(id:String,version:String,url:String)
	{
		_id = id;
		_version = version;
		_url = url;
	}
	private var _librarys:Vector.<SceneLinkLibrary> = new Vector.<SceneLinkLibrary>();
	public function addLibrary(value:SceneLinkLibrary):void
	{
		_librarys.push(value);
	}
	
	public function get librarys():Vector.<SceneLinkLibrary>
	{
		return _librarys;
	}
}

class SceneLinkLibrary
{
	private var _desc:String = "";
	public function set desc(value:String):void
	{
		_desc = value;
	}
	public function get desc():String
	{
		return _desc;
	}
	private var _id:String = "";
	public function set id(value:String):void
	{
		_id = value;
	}
	public function get id():String
	{
		return _id;
	}
	private var _version:String = "";
	public function set version(value:String):void
	{
		_version = value;
	}
	public function get version():String
	{
		return _version;
	}
	private var _url:String = "";
	public function set url(value:String):void
	{
		_url = value;
	}
	public function get url():String
	{
		return _url;
	}
	
	private var _isUIlib:Boolean = false;
	public function set isUIlib(value:Boolean):void
	{
		_isUIlib = value;
	}
	public function get isUIlib():Boolean
	{
		return _isUIlib;
	}
	
	public function SceneLinkLibrary(id:String,version:String,url:String,desc:String)
	{
		_id = id;
		_version = version;
		_url = url;
		_desc = desc;
	}
}