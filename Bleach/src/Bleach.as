package
{
	import bleach.event.BleachDefenseEvent;
	import bleach.module.loader.BaseLoader;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.Socket;
	
	[SWF(width="1000",height="600",backgroundColor="0x000000")]
	public class Bleach extends Sprite
	{
		private var _loader:BaseLoader = null;
		public function Bleach()
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