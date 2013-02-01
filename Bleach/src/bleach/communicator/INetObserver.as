package bleach.communicator
{
	import bleach.module.message.IMsg;
	
	import pixel.utility.IUpdate;

	public interface INetObserver extends IUpdate
	{
		function addListener(command:int,callback:Function):void;
		function removeListener(command:int,callback:Function):void;
		function broadcast(msg:IMsg):void;
	}
}