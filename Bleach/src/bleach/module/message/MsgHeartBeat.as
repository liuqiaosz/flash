package bleach.module.message
{
	import flash.utils.ByteArray;
	
	import pixel.utility.math.Int64;

	public class MsgHeartBeat extends MsgRequest
	{
		private var _stamp:Number = 0;
		private var _timestamp:Int64 = null;
		public function set timestamp(value:Number):void
		{
			_stamp = value;
			_timestamp = Int64.fromNumber(value);
		}
		public function get timestamp():Number
		{
			return _stamp;
		}
		public function MsgHeartBeat()
		{
			super(MsgIdConstants.MSG_HEARTBEAT);
		}
		
		override public function getMessage():ByteArray
		{
			var data:ByteArray = super.getMessage();
			data.writeInt(_timestamp.high);
			data.writeInt(_timestamp.low);
			return data;
		}
	}
}