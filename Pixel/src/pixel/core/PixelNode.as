package pixel.core
{
	import flash.display.Sprite;
	
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessageBus;
	
	use namespace PixelNs;
	/**
	 * Pixel精灵根节点
	 * 
	 * 位图精灵，音频精灵，动画位图精灵都从该根节点继承
	 * 
	 * 
	 **/
	public class PixelNode extends Sprite implements IPixelNode
	{
		public function PixelNode()
		{
		}
		
		public function addMessageListener(type:String,callback:Function):void
		{
			PixelMessageBus.instance.register(type,callback);
		}
		public function removeMessageListener(type:String,callback:Function):void
		{
			PixelMessageBus.instance.unRegister(type,callback);
		}
		public function dispatchMessage(msg:IPixelMessage):void
		{
			PixelMessageBus.instance.dispatchMessage(msg);
		}
		
		public function update():void
		{
		}
		
		public function dispose():void
		{
		}
	}
}