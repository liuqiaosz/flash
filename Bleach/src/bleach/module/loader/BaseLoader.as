package bleach.module.loader
{
	import bleach.event.BleachDefenseEvent;
	import bleach.module.GenericModule;
	import bleach.utils.Constants;
	import bleach.utils.ShareDisk;
	import bleach.utils.ShareObjectHelper;
	
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
		private var _loading:LoadMask = null;
		/**
		 * 公共素材包下载
		 * 
		 **/
		private function commLibraryDownload():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				traceDomain();
				var colorImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadColor");
				var whiteImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadWhite");
				
				var colorBitmap:BitmapData = new colorImgClass() as BitmapData;
				var whiteBitmap:BitmapData = new whiteImgClass() as BitmapData;
				
				_loading = new LoadMask(whiteBitmap,colorBitmap);
				_loading.x = (stage.stageWidth - whiteBitmap.width) * 0.5;
				_loading.y = (stage.stageHeight - whiteBitmap.height) * 0.5;
				addChild(_loading);
				
				rslLibraryDownload();
			});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void{
				trace("!");
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			//loader.load(new URLRequest(Constants.WEB_URL + "library/commlib.swf"),ctx);
			loader.load(new URLRequest("../../../../../Bleach/资源管理/commlib.swf"),ctx);
		}
		
		/**
		 * 共享库加载
		 **/
		private function rslLibraryDownload():void
		{
//			var loader:Loader = new Loader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
//				_loaded++;
//				_loading.progressUpdate(_loadTotal,_loaded);
//				msgDownload();
//				
//			});
//			var ctx:LoaderContext = new LoaderContext();
//			ctx.applicationDomain = ApplicationDomain.currentDomain;
//			//loader.load(new URLRequest(Constants.WEB_URL + "library/BleachLibrary.swf"),ctx);
//			loader.load(new URLRequest("/Users/LiuQiao/Documents/Developer/Code/flash/BleachLibrary/bin-debug/BleachLibrary.swf"),ctx);
			_loaded++;
			_loading.progressUpdate(_loadTotal,_loaded);
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
				_loading.progressUpdate(_loadTotal,_loaded);
				coreDownload();
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			//loader.load(new URLRequest(Constants.WEB_URL + "BleachScene.swf"),ctx);
			loader.load(new URLRequest("death/def/module/message/MsgLibrary.swf"),ctx);
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
				_loading.progressUpdate(_loadTotal,_loaded);
				_mainApp = loader.content;
				
				//设置面具发光
				_loading.maskGlow();
				_lazy = new Timer(500,1);
				_lazy.addEventListener(TimerEvent.TIMER,completeLazy);
				_lazy.start();
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = ApplicationDomain.currentDomain;
			//loader.load(new URLRequest(Constants.WEB_URL + "BleachScene.swf"),ctx);
			loader.load(new URLRequest("BleachDefense.swf"),ctx);
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

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class LoadMask extends Sprite
{
	private var _text:TextField = null;
	private var _image:Bitmap = null;
	private var _bitmap:BitmapData = null;
	private var _whiteMask:BitmapData = null;
	private var _colorMask:BitmapData = null;
	private var _dest:Point = new Point();
	private var _rect:Rectangle = new Rectangle(0,0,0,0);
	private var _format:TextFormat = null;
	public function LoadMask(whiteMask:BitmapData,colorMask:BitmapData)
	{
		_whiteMask = whiteMask;
		_colorMask = colorMask;
		
		if(!_whiteMask || !_colorMask)
		{
			throw new Error("Invalid mask");
		}
		
		_bitmap = new BitmapData(_colorMask.width,_colorMask.height);
		_bitmap.copyPixels(_whiteMask,_whiteMask.rect,_dest);
		_rect.width = _colorMask.width;
		_image = new Bitmap(_bitmap);
		addChild(_image);
		_text = new TextField();
		_text.border = true;
		_text.width = whiteMask.width;
		_text.y = _colorMask.height + 20;
		_format = new TextFormat();
		_format.color = 0xFFFFFF;
		_format.align = TextFormatAlign.CENTER;
		_text.setTextFormat(_format);
		addChild(_text);
	}
	
	public function maskGlow(color:uint = 0xFF0000):void
	{
		var filter:GlowFilter = new GlowFilter(0xff0000,1,30,30);
		_image.filters = [filter];
	}
	
	/**
	 * 更新
	 **/
	public function progressUpdate(total:Number,loaded:Number):void
	{
		var percent:Number = loaded / total;
		_rect.height = _colorMask.height * percent;
		if(_rect.height > _colorMask.height)
		{
			_rect.height = _colorMask.height;
		}
		_bitmap.copyPixels(_colorMask,_rect,_dest);
	}
	
	public function textUpdate(value:String):void
	{
		_text.text = value;
		_text.setTextFormat(_format);
	}
}