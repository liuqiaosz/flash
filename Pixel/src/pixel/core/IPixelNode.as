package pixel.core
{
	import pixel.utility.IDispose;
	import pixel.utility.IUpdate;

	/**
	 * Pixel精灵节点接口
	 * 
	 * 最小动画单位
	 * 
	 **/
	public interface IPixelNode extends IPixelGeneric,IPixelMessageProxy,IDispose,IUpdate
	{
	}
}