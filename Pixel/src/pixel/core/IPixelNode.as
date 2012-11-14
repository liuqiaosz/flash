package pixel.core
{
	import flash.display.BitmapData;

	/**
	 * Pixel精灵节点接口
	 * 
	 * 最小动画单位
	 * 
	 **/
	public interface IPixelNode extends IPixelGeneric
	{
		/**
		 * 状态更新
		 * 
		 * 
		 **/
		function update():void;
	}
}