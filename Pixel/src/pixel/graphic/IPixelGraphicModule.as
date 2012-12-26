package pixel.graphic
{
	import pixel.core.IPixelLayer;

	public interface IPixelGraphicModule
	{
		/**
		 * 渲染
		 * 
		 * 
		 **/
		function render(scenes:Vector.<IPixelLayer>):void;
	}
}