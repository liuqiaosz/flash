package death.def.communicator
{
	import death.def.module.message.IMsg;
	import death.def.module.scene.GenericScene;

	public interface IComm extends IPixelNetConnection
	{
		//function send(sender:GenericScene,message:IPixelNetMessage):void;
		function addMessageListener(type:int,listener:Function):void;
		function removeMessageListener(type:int,listener:Function):void;
		function createMessage(id:int):IMsg;
	}
}