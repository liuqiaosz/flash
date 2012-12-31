package death.def.communication
{
	import death.def.scene.GenericScene;
	
	import pixel.net.IPixelNetConnection;
	import pixel.net.msg.IPixelNetMessage;

	public interface IComm extends IPixelNetConnection
	{
		//function send(sender:GenericScene,message:IPixelNetMessage):void;
		function addMessageListener(type:int,listener:Function):void;
		function removeMessageListener(type:int,listener:Function):void;
	}
}