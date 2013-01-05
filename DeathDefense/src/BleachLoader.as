package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.ui.control.UIButton;
	import pixel.utility.ColorCode;
	import pixel.utility.System;
	import pixel.utility.SystemMode;
	import pixel.utility.Tools;

	/**
	 * 加载器
	 * 
	 * 1: 加载全局配置
	 * 
	 * 2: 加载全局纹理
	 * 
	 * 3: 加载动态库
	 * 
	 * 4: 加载主程序
	 * 
	 * 
	 * 
	 **/
	[SWF(width="1280",height="600",backgroundColor="0x000000")]
	public class BleachLoader extends Sprite
	{
		private var _loader:Loader = null;
		public function BleachLoader()
		{
			_loader = new Loader();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				loader = new Loader();
				loader.load(new URLRequest("BleachDefense.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event2:Event):void{
					addChild(loader);
				});
			});
			var ctx:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			loader.load(new URLRequest("/Users/LiuQiao/Documents/Developer/Code/flash/BleachLibrary/bin-debug/BleachLibrary.swf"),ctx);
		}
		
		private function loadConfig():void
		{
			var url:URLLoader = new URLLoader();
			url.data = URLLoaderDataFormat.TEXT;
			url.addEventListener(Event.COMPLETE,configComplete);
		}
		
		/**
		 * 配置下载完毕
		 **/
		private function configComplete(event:Event):void
		{
		}
	}
}