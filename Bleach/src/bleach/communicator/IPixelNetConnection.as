package bleach.communicator
{
	import flash.events.IEventDispatcher;
	import bleach.module.message.IMsg;
	

	public interface IPixelNetConnection extends IEventDispatcher
	{
		function connect(ip:String,port:int,encode:String = ""):void;
		function close():void;
		function sendMessage(msg:IMsg):void;
		function sendString(value:String):void;
	}
}