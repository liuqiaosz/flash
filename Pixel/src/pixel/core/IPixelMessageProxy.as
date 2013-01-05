package pixel.core
{
	import pixel.message.IPixelMessage;

	public interface IPixelMessageProxy
	{
		function addMessageListener(type:String,callback:Function):void;
		function removeMessageListener(type:String,callback:Function):void;
		function dispatchMessage(msg:IPixelMessage):void;
	}
}