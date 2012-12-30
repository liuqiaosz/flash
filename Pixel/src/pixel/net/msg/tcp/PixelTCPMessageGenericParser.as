package pixel.net.msg.tcp
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

	public class PixelTCPMessageGenericParser extends EventDispatcher implements IPixelTCPMessageParser
	{
		public function PixelTCPMessageGenericParser()
		{
			super();
		}
		
		public function decode(data:ByteArray):IPixelTCPMessage
		{
			return null;
		}
		
		protected function headerDecode(data:ByteArray):IpixelTCPMessageHeader
		{
			return null;
		}
		
		protected function bodyDecode(data:ByteArray):IPixelTCPMessageBody
		{
			return null;
		}
		
		public function encode(value:IPixelTCPMessage):ByteArray
		{
			return null;
		}
	}
}