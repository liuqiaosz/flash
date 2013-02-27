package bleach.communicator
{
	import bleach.protocol.IProtocol;
	import bleach.scene.GenericScene;

	public interface ICommunicator
	{
		function addNetMessageListener(type:int,listener:Function):void;
		function removeNetMessageListener(type:int,listener:Function):void;
	}
}