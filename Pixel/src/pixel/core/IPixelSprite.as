package pixel.core
{
	import flash.display.BitmapData;

	/**
	 * Pixel精灵节点接口
	 * 
	 * 最小动画单位
	 * 
	 **/
	public interface IPixelSprite extends IPixelGeneric
	{
		/**
		 * 返回当前精灵的位图
		 * 
		 **/
		function get clip():BitmapData;
	}
}