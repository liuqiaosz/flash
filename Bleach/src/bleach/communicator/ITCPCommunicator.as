package bleach.communicator
{
	import bleach.module.message.IMsg;
	
	import flash.events.IEventDispatcher;
	

	public interface ITCPCommunicator extends IEventDispatcher
	{
		function connect(ip:String = "",port:int = 9090,encode:String = ""):void;
		function close():void;
		function sendMessage(msg:IMsg):void;
		function sendString(value:String):void;
		function isConnected():Boolean;
	}
}