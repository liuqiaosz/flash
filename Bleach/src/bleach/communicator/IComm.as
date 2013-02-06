package bleach.communicator
{
	import bleach.module.protocol.IProtocol;
	import bleach.scene.GenericScene;

	public interface IComm
	{
		//function send(sender:GenericScene,message:IPixelNetMessage):void;
		function addNetMessageListener(type:int,listener:Function):void;
		function removeNetMessageListener(type:int,listener:Function):void;
	}
}