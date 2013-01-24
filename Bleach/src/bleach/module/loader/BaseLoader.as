package bleach.module.loader
{
	import bleach.event.BleachDefenseEvent;
	import bleach.module.GenericModule;
	import bleach.utils.Constants;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class BaseLoader extends GenericModule
	{
		private var _mainApp:DisplayObject = null;
		
		public function get mainApp():DisplayObject
		{
			return _mainApp;
		}
		public function BaseLoader()
		{
		}
		
		override protected function initializer():void
		{
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,1280,600);
			this.graphics.endFill();
			commLibraryDownload();
		}
		
		/**
		 * 加载配置
		 **/
		private function loadConfig():void
		{
			var conn:URLLoader = new URLLoader();
			conn.dataFormat = URLLoaderDataFormat.BINARY;
			conn.addEventListener(Event.COMPLETE,configComplete);
			var url:URLRequest = new URLRequest();
			url.method = "POST";
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes("0003002");
			url.data = data;
			conn.load(url);
		}
		
		private var _loadTotal:int = 3;
		private var _loaded:int = 0;
		private var _mainVer:String = "";
		private var _rslVer:String = "";
		private var _msgVer:String = "";
		/**
		 * 配置下载完毕
		 **/
		private function configComplete(event:Event):void
		{
			URLLoader(event.target).removeEventListener(Event.COMPLETE,configComplete);
			var conn:URLLoader = event.target as URLLoader;
			var data:ByteArray = conn.data as ByteArray;
			
			if(!data)
			{
				//异常！！
			}
			data.readUTFBytes(4);
			data.readUTFBytes(3);
			data.readUTFBytes(4);
			
			//获取服务端最新配置
			_mainVer = data.readUTFBytes(3);
			_rslVer = data.readUTFBytes(3);
			_msgVer = data.readUTFBytes(3);
		}
		//private var _loading:LoadMask = null;
		/**
		 * 公共素材包下载
		 * 
		 **/
		private function commLibraryDownload():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				loader.unload();
				
//				var colorImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadColor");
//				var whiteImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadWhite");
//				
//				var colorBitmap:BitmapData = new colorImgClass() as BitmapData;
//				var whiteBitmap:BitmapData = new whiteImgClass() as BitmapData;
//				
//				_loading = new LoadMask(whiteBitmap,colorBitmap);
//				_loading.x = (stage.stageWidth - whiteBitmap.width) * 0.5;
//				_loading.y = (stage.stageHeight - whiteBitmap.height) * 0.5;
				addChild(MaskLoading.instance);
				
				rslLibraryDownload();
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			//loader.load(new URLRequest(Constants.WEB_URL + "library/commlib.swf"),ctx);
			loader.load(new URLRequest("commlib.swf"),ctx);
		}
		
		/**
		 * 共享库加载
		 **/
		private function rslLibraryDownload():void
		{
//			var loader:Loader = new Loader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
//				_loaded++;
//				//_loading.progressUpdate(_loadTotal,_loaded);
//				MaskLoading.instance.progressUpdate(_loadTotal,_loaded);
//				msgDownload();
//				
//			});
//			var ctx:LoaderContext = new LoaderContext();
//			ctx.applicationDomain = ApplicationDomain.currentDomain;
//			loader.load(new URLRequest("BleachLibrary.swf"),ctx);
			_loaded++;
			MaskLoading.instance.progressUpdate(_loadTotal,_loaded);
			msgDownload();
		}
		
		/**
		 * 消息库加载
		 **/
		private function msgDownload():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				_loaded++;
				MaskLoading.instance.progressUpdate(_loadTotal,_loaded);
				coreDownload();
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			//loader.load(new URLRequest(Constants.WEB_URL + "BleachScene.swf"),ctx);
			loader.load(new URLRequest("bleach/module/message/MsgLibrary.swf"),ctx);
		}
		
		private var _lazy:Timer = null;
		/**
		 * 主程序加载
		 **/
		private function coreDownload():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				_loaded++;
				_mainApp = loader.content;
				MaskLoading.instance.progressUpdate(_loadTotal,_loaded);
				_lazy = new Timer(100,1);
				_lazy.addEventListener(TimerEvent.TIMER,completeLazy);
				_lazy.start();
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			loader.load(new URLRequest("BleachLauncher.swf"),ctx);
		}
		
		/**
		 * 初始化完成延迟处理
		 **/
		private function completeLazy(event:TimerEvent):void
		{
			_lazy.stop();
			_lazy.removeEventListener(TimerEvent.TIMER,completeLazy);
			_lazy = null;
			var notify:BleachDefenseEvent = new BleachDefenseEvent(BleachDefenseEvent.BLEACH_INIT_COMPLETE);
			dispatchEvent(notify);
		}
		
		private function traceDomain():void
		{
			var params:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
			for each(var param:String in params)
			{
				trace(param);
			}
		}
	}
}
