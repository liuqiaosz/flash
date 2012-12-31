package pixel.net.msg.tcp
{
	import flash.utils.ByteArray;

	public interface IPixelTCPMessage
	{
		//消息ID
		function get id():int;
		function set id(value:int):void;
		
		//消息头和消息体
		function get head():IpixelTCPMessageHeader;
		function get body():IPixelTCPMessageBody;
		
		function decode(data:ByteArray):void;
		function encode():ByteArray;
	}
}