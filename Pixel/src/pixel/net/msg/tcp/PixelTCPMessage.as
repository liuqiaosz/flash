package pixel.net.msg.tcp
{
	import flash.utils.ByteArray;

	public class PixelTCPMessage implements IPixelTCPMessage
	{
		public function PixelTCPMessage(id:int)
		{
			_id = id;
		}
		
		private var _id:int = 0;
		//消息ID
		public function get id():int
		{
			return _id;
		}
		public function set id(value:int):void
		{
			_id = value;
		}
		
		//消息头和消息体
		public function get head():IpixelTCPMessageHeader
		{
			return null;
		}
		public function get body():IPixelTCPMessageBody
		{
			return null;
		}
		
		public function decode(data:ByteArray):void
		{
		}
		public function encode():ByteArray
		{
			return null;
		}
	}
}