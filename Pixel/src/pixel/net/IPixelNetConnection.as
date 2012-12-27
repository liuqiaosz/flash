package pixel.net
{
	import flash.events.IEventDispatcher;
	
	import pixel.net.msg.IPixelNetMessage;

	public interface IPixelNetConnection extends IEventDispatcher
	{
		function connect():void;
		function close():void;
		function sendMessage(msg:IPixelNetMessage):void;
		function sendString(value:String):void;
	}
}