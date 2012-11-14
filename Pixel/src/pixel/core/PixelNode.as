package pixel.core
{
	import flash.display.Sprite;

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
		
		public function update():void
		{
		}
	}
}