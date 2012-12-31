package pixel.net.msg
{
	public interface IPixelNetMessage
	{
		function set id(value:int):void;
		function get id():int;
		function getMessage():String;
	}
}