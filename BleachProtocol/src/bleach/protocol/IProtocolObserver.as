package bleach.protocol
{
	import bleach.protocol.IProtocol;
	
	import pixel.utility.IUpdate;

	public interface IProtocolObserver extends IUpdate
	{
		function addListener(command:int,callback:Function):void;
		function removeListener(command:int,callback:Function):void;
		function broadcast(msg:IProtocol):void;
	}
}