package death.def.communicator
{
	import flash.events.IEventDispatcher;
	import death.def.module.message.IMsg;
	

	public interface IPixelNetConnection extends IEventDispatcher
	{
		function connect(ip:String,port:int,encode:String = ""):void;
		function close():void;
		function sendMessage(msg:IMsg):void;
		function sendString(value:String):void;
	}
}