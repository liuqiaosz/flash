package pixel.net.msg.tcp
{
	import flash.utils.ByteArray;

	public interface IPixelTCPMessageParser
	{
		function decode(data:ByteArray):IPixelTCPMessage;
		function encode(value:IPixelTCPMessage):ByteArray;
	}
}