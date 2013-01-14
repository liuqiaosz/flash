package 
{
	import death.def.event.BleachDefenseEvent;
	import death.def.module.loader.BaseLoader;
	import death.def.utils.Constants;
	import death.def.utils.ShareDisk;
	import death.def.utils.ShareObjectHelper;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	[SWF(width="1280",height="600",backgroundColor="0x000000")]
	public class BleachLoader extends Sprite
	{
		private var _loader:BaseLoader = null;
		public function BleachLoader()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			_loader = new BaseLoader();
			addChild(_loader);
			addEventListener(BleachDefenseEvent.BLEACH_INIT_COMPLETE,initComplete);
		}
		
		private function initComplete(event:BleachDefenseEvent):void
		{
			_loader.visible = false;
			addChild(_loader.mainApp);
			if(contains(_loader))
			{
				removeChild(_loader);
			}
		}
	}
}
