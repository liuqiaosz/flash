package pixel.message
{
	import pixel.core.PixelNs;
	import pixel.utility.IUpdate;

	use namespace PixelNs;
	
	public interface IPixelMessageBus extends IUpdate
	{
		//注册消息
		function register(message:String,callback:Function):void;
		//取消注册消息
		function unRegister(message:String,callback:Function):void;
		
		function dispatchMessage(message:IPixelMessage):void;
	}
}