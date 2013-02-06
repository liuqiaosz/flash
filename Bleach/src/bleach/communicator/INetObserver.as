package bleach.communicator
{
	import bleach.module.protocol.IProtocol;
	
	import pixel.utility.IUpdate;

	public interface INetObserver extends IUpdate
	{
		function addListener(command:int,callback:Function):void;
		function removeListener(command:int,callback:Function):void;
		function broadcast(msg:IProtocol):void;
	}
}