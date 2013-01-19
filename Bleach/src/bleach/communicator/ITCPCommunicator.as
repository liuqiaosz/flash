package bleach.communicator
{
	import bleach.module.message.IMsg;
	import bleach.module.message.IMsgRequest;
	
	import flash.events.IEventDispatcher;
	

	public interface ITCPCommunicator extends IEventDispatcher
	{
		function connect(ip:String = "",port:int = 9090,encode:String = ""):void;
		function close():void;
		function sendMessage(msg:IMsgRequest):void;
		function sendString(value:String):void;
		function isConnected():Boolean;
	}
}