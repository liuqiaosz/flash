package bleach
{
	import bleach.cfg.BleachSystem;
	import bleach.cfg.GlobalConfig;
	import bleach.communicator.ITCPCommunicator;
	import bleach.communicator.NetObserver;
	import bleach.communicator.TCPCommunicator;
	import bleach.event.BleachEvent;
	import bleach.event.BleachProgressEvent;
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.module.loader.MaskLoading;
	import bleach.module.loader.ProgressLoading;
	import bleach.module.message.IMsg;
	import bleach.module.message.IMsgRequest;
	import bleach.module.message.MsgGeneric;
	import bleach.module.message.MsgHeartBeat;
	import bleach.module.message.MsgHeartBeatResp;
	import bleach.module.message.MsgIdConstants;
	import bleach.scene.IScene;
	import bleach.scene.LoginScene;
	import bleach.scene.PopUpMaskScene;
	import bleach.scene.WorldScene;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import pixel.core.IPixelDirector;
	import pixel.core.IPixelLayer;
	import pixel.core.PixelDirector;
	import pixel.core.PixelLauncher;
	import pixel.core.PixelSprite;
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessage;
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
		private var _initialized:Boolean = false;
		private var _channel:ITCPCommunicator = null;
		private var _loading:Boolean = false;
		private var _topLayer:Sprite = null;
		private var _contentLayer:Sprite = null;
		private var _system:BleachSystem = null;
		private var _connectTryCount:int = 0;
		private var _progressLoad:ILoading = null;
		public function BleachDirector()
		{
			super();
		}
		
		override public function initializer():void
		{
			super.initializer();
			
			//加载配置
			configInit();
			
			//连接服务器
			addMessageListener(BleachNetMessage.BLEACH_NET_CONNECTED,serverConnected);
			addMessageListener(BleachNetMessage.BLEACH_NET_CONNECT_ERROR,serverConnectError);
			addMessageListener(BleachNetMessage.BLEACH_NET_RECONNECT,serverConnectError);
			_channel = new TCPCommunicator();
			_channel.connect(BleachSystem.instance.host,BleachSystem.instance.port);
			//serverConnected(null);
		}
		
		/**
		 * 连接失败
		 **/
		private function serverConnectError(msg:BleachNetMessage):void
		{
			if(_connectTryCount < BleachSystem.instance.reConnectCount)
			{
				_connectTryCount++;
				_channel.connect(BleachSystem.instance.host,BleachSystem.instance.port);
				trace("连接错误,重连...");
			}
			else
			{
				//超过重连次数
				trace("重连超过次数");
			}
		}
		
		private var _heartBeat:HeartBeat = null;
		/**
		 * 服务端连接成功，开启运行
		 * 
		 **/
		private function serverConnected(msg:BleachNetMessage):void
		{
			//重置连接尝试次数
			_connectTryCount = 0;
			if(!_initialized)
			{
				_heartBeat = new HeartBeat(BleachSystem.instance.heartbeat,BleachSystem.instance.heartbeatot);
				_initialized = true;
				addMessageListener(BleachMessage.BLEACH_WORLD_REDIRECT,directScene);
				addMessageListener(BleachMessage.BLEACH_POPWINDOW_MODEL,popUpWindowModel);
				addMessageListener(BleachLoadingMessage.BLEACH_LOADING_SHOW,loadingShow);
				addMessageListener(BleachLoadingMessage.BLEACH_LOADING_HIDE,loadingHide);
//				addMessageListener(BleachLoadingMessage.BLEACH_LOADING_UPDATE,loadingUpdate);
				addMessageListener(BleachNetMessage.BLEACH_NET_SENDMESSAGE,onMessageSend);
				
				addMessageListener(BleachMessage.BLEACH_POPCLOSE,onClosePopScene);
				
				var notify:BleachMessage = null;
				switch(BleachSystem.instance.portal)
				{
					case GlobalConfig.SYSTEM_PORTAL_NORMAL:
						notify = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
						notify.value = "loginScene";
						notify.deallocOld = true;
						dispatchMessage(notify);
						break;
				}
			}
			//重新开启心跳
			_heartBeat.start();
		}
		
		private function onClosePopScene(msg:PixelMessage):void
		{
			PopUpMaskScene.instance.hide();
			this.removeSceneTop(PopUpMaskScene.instance);
		}
		
		/**
		 * 非模式弹出窗
		 **/
		private function popUpWindow(msg:BleachMessage):void
		{
			
		}
		
		/**
		 * 模式弹出窗
		 **/
		private function popUpWindowModel(msg:BleachMessage):void
		{
			//var id:String = msg.value as String;
			//_progressLoad = ProgressLoading.instance;
			//this.addSceneTop(_progressLoad as Sprite);
			//PopUpMaskScene.instance.show(_sceneCache[msg.value] as SceneModule);
			PopUpMaskScene.instance.show(_sceneCache["loginScene"] as SceneModule);
			addSceneTop(PopUpMaskScene.instance);
		}
		
		/**
		 * 发送消息事件处理
		 **/
		private function onMessageSend(msg:BleachNetMessage):void
		{
			_channel.sendMessage(msg.value as IMsgRequest);
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
			var system:XML = config.system[0];
			
			BleachSystem.instance.heartbeat = new Number(system.heartbeat);
			BleachSystem.instance.heartbeatot = new Number(system.heartbeattimeout);
			BleachSystem.instance.reConnectCount = new Number(system.reconnect);
			BleachSystem.instance.host = system.remotehost;
			BleachSystem.instance.host = "125.65.108.148";
			BleachSystem.instance.port = new Number(system.remoteport);
			BleachSystem.instance.portal = new Number(system.portal);
			
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
					var uilib:String = lib.@uilib;
					if(uilib == "true")
					{
						library.isUIlib = new Boolean(lib.@uilib);
					}
					scene.addLibrary(library);
				}
				_sceneMap[scene.id] = scene;
			}
			System.disposeXML(config);
		}
		
		
		private function loadingShow(msg:BleachLoadingMessage):void
		{
			addSceneTop(_progressLoad as Sprite);
			_loading = true;
		}
		
		private function loadingHide(msg:BleachLoadingMessage):void
		{
			TweenLite.to(_progressLoad,0.5,{
				"alpha" : 0,
				onComplete : hideComplete
			});
		}
		
		private function hideComplete():void
		{
			removeSceneTop(_progressLoad as Sprite);
			//MaskLoading.instance.alpha = 1;
			Sprite(_progressLoad).alpha = 1;
			_loading = false;
		}
		
		
		private var _swapDealloc:Boolean = false;
		/**
		 * 场景切换
		 * 
		 **/
		private function directScene(msg:BleachMessage):void
		{
			//场景切换使用面具加载
			_progressLoad = MaskLoading.instance;
			_downloader = null;
//			_downlodLinkLibrary = null;
			_swapDealloc = msg.deallocOld;
			if(_swapDealloc && _module)
			{
				_module.clear();
				_module = null;
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
				swapScene(_module.sceneContent.content,_swapDealloc);
			}
			else
			{
				//创建该场景的域
//				_module.sceneDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				//_librarys = new Vector.<Loader>();
//				_module.library = new Vector.<Loader>();
//				_downloaded = 0;
//				libraryDownload();
				//显示加载界面
				
				_downloader = new SceneDownloader(_module);
				_downloader.addEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
				_downloader.addEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
				_downloader.addEventListener(BleachProgressEvent.BLEACH_DOWNLOAD_PROGRESS,progressUpdate);
				_downloader.begin();
				dispatchMessage(new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_SHOW));
			}
		}
		
		
		private function progressUpdate(event:BleachProgressEvent):void
		{
			if(_loading)
			{
				_progressLoad.progressUpdate(event.total,event.loaded);
			}
		}
		
		/**
		 * 场景链接库，主文件下载完毕
		 * 
		 **/
		private function onSceneDownloadComplete(event:BleachEvent):void
		{
			var module:SceneModule = event.value as SceneModule;
			swapScene(module.sceneContent.content,_swapDealloc);
			this.loadingHide(null);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
			_downloader.removeEventListener(BleachProgressEvent.BLEACH_DOWNLOAD_PROGRESS,progressUpdate);
			_downloader = null;
		}
		
		/**
		 * 场景模块下载失败
		 **/
		private function onSceneDownloadFailure(event:BleachEvent):void
		{
			this.loadingHide(null);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
			_downloader = null;
		}
		private var _downloader:SceneDownloader = null;
		private var _module:SceneModule = null;

		/**
		 * 更新
		 * 
		 **/
		override public function frameUpdate(message:PixelMessage):void
		{
			super.frameUpdate(message);
			if(_heartBeat)
			{
				_heartBeat.update();
			}
			if(_activedScene)
			{
				IPixelLayer(_activedScene).update();
			}
		}

		/**
		 * 
		 * 场景切换重写
		 * 这里加入切换效果的支持
		 * 
		 **/
		override protected function swapScene(newScene:DisplayObject,oldDealloc:Boolean = true):void
		{
			//激活
			IScene(newScene).actived();
			addScene(newScene);
			if(_activedScene)
			{
				//_newScene = newScene;
				//sceneFadeOut(_activedScene);
				
				removeScene(_activedScene);
				IScene(_activedScene).unactived();
//				IScene(_activedScene).pause();
				if(oldDealloc)
				{
					IScene(_activedScene).dealloc();
				}
				_activedScene = null;
				_activedScene = newScene;
			}
			else
			{
				_activedScene = newScene;
				//sceneFadeIn(_activedScene);
			}
		}
	}
}