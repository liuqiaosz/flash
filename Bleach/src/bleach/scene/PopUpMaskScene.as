package bleach.scene
{
	import bleach.BleachDirector;
	import bleach.SceneDownloader;
	import bleach.SceneModule;
	import bleach.event.BleachEvent;
	import bleach.event.BleachProgressEvent;
	import bleach.message.BleachMessage;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;
	import pixel.core.PixelScreen;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.vo.UIMod;

	/**
	 * 弹出场景，至于当前场景之上
	 * 
	 * 
	 **/
	public class PopUpMaskScene extends PixelNode
	{
		private static var _instance:PopUpMaskScene = null;
		private var _module:SceneModule = null;
		//背景遮罩
		private var _mask:Sprite = null;
		
		private var _content:Sprite = null;
		private var _progress:UIProgress = null;
		private var _screen:PixelScreen = null;
		private var _downloader:SceneDownloader = null;
		public function PopUpMaskScene()
		{
			if(_instance)
			{
				throw new Error("Singlton");
			}
			_screen = PixelLauncher.launcher.screen;
			var commonUI:Object = getDefinitionByName("ui.common");
			var mod:UIMod = UIControlFactory.instance.decode(new commonUI() as ByteArray);
			_progress = mod.controls.pop().control as UIProgress;
		}
		
		public function show(module:SceneModule,model:Boolean = true):void
		{
			if(model)
			{
				_module = module;
				if(!_mask)
				{
					//加入遮罩
					_mask = new Sprite();
					_mask.graphics.clear();
					_mask.graphics.beginFill(0x000000,0.7);
					_mask.graphics.drawRect(0,0,_screen.screenWidth,_screen.screenHeight);
					_mask.graphics.endFill();
					addChild(_mask);
					_mask.mouseEnabled = false;
					_mask.mouseChildren = false;
				}
				_module.clear();
				if(_module.loaded)
				{
					addContent(_module.sceneContent.content as Sprite);
				}
				else
				{
					_downloader = new SceneDownloader(_module);
					_downloader.addEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
					_downloader.addEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
					_downloader.addEventListener(BleachProgressEvent.BLEACH_DOWNLOAD_PROGRESS,progressUpdate);
					_downloader.begin();
					addChild(_progress);
					_progress.x = (_screen.screenWidth - _progress.width) * .5;
					_progress.y = (_screen.screenHeight - _progress.height) * .5;
				}
			}
		}
		
		private function progressUpdate(event:BleachProgressEvent):void
		{
			if(_progress)
			{
				_progress.progressUpdate(event.total,event.loaded);
			}
		}
		
		/**
		 * 场景链接库，主文件下载完毕
		 * 
		 **/
		private function onSceneDownloadComplete(event:BleachEvent):void
		{
			var module:SceneModule = event.value as SceneModule;
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
			_downloader.removeEventListener(BleachProgressEvent.BLEACH_DOWNLOAD_PROGRESS,progressUpdate);
			_downloader = null;
			removeChild(_progress);
			addContent(module.sceneContent.content as Sprite);
//			dispatchMessage(new BleachMessage(BleachMessage.BLEACH_POPCLOSE));
		}
		
		/**
		 * 场景模块下载失败
		 **/
		private function onSceneDownloadFailure(event:BleachEvent):void
		{
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE,onSceneDownloadComplete);
			_downloader.removeEventListener(BleachEvent.BLEACH_SCENE_DOWNLOAD_FAILURE,onSceneDownloadFailure);
			_downloader.removeEventListener(BleachProgressEvent.BLEACH_DOWNLOAD_PROGRESS,progressUpdate);
			removeChild(_progress);
			_downloader = null;
		}
		
		public function addContent(spr:Sprite):void
		{
			_content = spr;
			_content.scaleX = 0;
			_content.scaleY = 0;
			addChild(_content);
			TweenLite.to(_content,2,{scaleX: 1,scaleY: 1,
				onUpdate: onTweenUpdate,
				onComplete: onTweenComplete,
				ease:Back.easeOut});
		}
		
		private function onTweenComplete():void
		{
			
		}
		
		private function onTweenUpdate():void
		{
			_content.x = (_screen.screenWidth - _content.scaleX * _content.width) * 0.5;
			_content.y = (_screen.screenHeight - _content.scaleY * _content.height) * 0.5;
		}
		
		public function hide():void
		{
			if(_mask && contains(_mask))
			{
				removeChild(_mask);
			}
			if(_content && contains(_content))
			{
				removeChild(_content);
			}
		}
		
		public static function get instance():PopUpMaskScene
		{
			if(!_instance)
			{
				_instance = new PopUpMaskScene();
			}
			return _instance;
		}
	}
}