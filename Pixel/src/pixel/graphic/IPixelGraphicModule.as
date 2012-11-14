package pixel.graphic
{
	import pixel.scene.IPixelScene;

	public interface IPixelGraphicModule
	{
		/**
		 * 渲染
		 * 
		 * 
		 **/
		function render(scenes:Vector.<IPixelScene>):void;
	}
}