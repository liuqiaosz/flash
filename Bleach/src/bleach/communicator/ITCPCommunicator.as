package bleach.communicator
{
	import bleach.module.protocol.IProtocol;
	import bleach.module.protocol.IProtocolRequest;
	
	import flash.events.IEventDispatcher;
	

	public interface ITCPCommunicator extends IEventDispatcher
	{
		function connect(ip:String = "",port:int = 9090,encode:String = ""):void;
		function close():void;
		function sendMessage(msg:IProtocolRequest):void;
		function sendString(value:String):void;
		function isConnected():Boolean;
	}
}