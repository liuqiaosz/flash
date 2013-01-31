package
{
	import bleach.event.BleachEvent;
	import bleach.module.loader.BaseLoader;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import pixel.utility.Tools;
	import pixel.utility.math.Int64;
	
	[SWF(width="1000",height="600",backgroundColor="0xFFFFFF")]
	public class Bleach extends Sprite
	{
		private var _loader:BaseLoader = null;
		public function Bleach()
		{
//			var value:Number = new Date().time;
//			
//			trace("[" + value + "]");
//			
//			var v:Int64 = Int64.fromNumber(value);
//			var data:ByteArray =new ByteArray();
//			data.writeInt(v.high);
//			data.writeInt(v.low);
//			data.position = 0;
//			var cv:Number = Tools.readInt64(data);
//			trace("[" + cv + "]");
//			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			_loader = new BaseLoader();
			addChild(_loader);
			addEventListener(BleachEvent.BLEACH_INIT_COMPLETE,initComplete);
		}
		
		private function initComplete(event:BleachEvent):void
		{
			_loader.visible = false;
			addChild(_loader.mainApp);
			if(contains(_loader))
			{
				removeChild(_loader);
				_loader = null;
			}
		}
	}
}