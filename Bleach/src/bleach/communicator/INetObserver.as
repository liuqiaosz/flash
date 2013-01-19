package bleach.communicator
{
	import bleach.module.message.IMsg;

	public interface INetObserver
	{
		function addListener(command:int,callback:Function):void;
		function removeListener(command:int,callback:Function):void;
		function broadcast(msg:IMsg):void;
	}
}