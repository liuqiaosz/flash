package bleach
{
	import bleach.event.BleachEvent;
	import bleach.message.BleachLoadingMessage;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.core.PixelNode;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.asset.PixelLoaderAssetLibrary;

	public class SceneDownloader extends PixelNode
	{
		private var _module:SceneModule = null;
		public function SceneDownloader(module:SceneModule)
		{
			_module = module;
		}
		
		public function begin():void
		{
			_module.sceneDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			_module.library = new Vector.<Loader>();
			libraryDownload();
		}
		
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
				var a:URLRequest
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
					sceneDownload();
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
			if(_downlodLinkLibrary.isUIlib)
			{
				//UI库资源
				PixelAssetManager.instance.addAssetLibrary(new PixelLoaderAssetLibrary(_downloader,_downlodLinkLibrary.id));
			}
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
//			var complete:BleachLoadingMessage = new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_COMPLETE);
//			complete.value = _module;
//			dispatchMessage(complete);
			var notify:BleachEvent = new BleachEvent(BleachEvent.BLEACH_SCENE_DOWNLOAD_COMPLETE);
			notify.value = _module;
			_module.loaded = true;
			dispatchEvent(notify);
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
	}
}