package bleach.module.message
{
	import flash.utils.ByteArray;
	
	import pixel.utility.Tools;
	import pixel.utility.math.Int64;

	public class MsgHeartBeatResp extends MsgResponse
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
		public function MsgHeartBeatResp()
		{
			super(MsgIdConstants.MSG_HEARTBEAT_RESP);
		}
		
		override public function setMessage(data:ByteArray):void
		{
			var source:ByteArray = data as ByteArray;
			timestamp = Tools.readInt64(source);
		}
	}
}