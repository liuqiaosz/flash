package pixel.graphic
{
	import pixel.scene.IPixelScene;

	public interface IPixelGraphicModule
	{
		/**
		 * 变更渲染模式
		 * 
		 * 0: 默认对象列表
		 * 1: 位图渲染
		 * 2: 混合模式
		 * 
		 * 
		 * 目前关闭，只支持位图渲染
		 * 
		 **/
//		function changeRenderMode(mode:int):void;
		
		/**
		 * 渲染
		 * 
		 * 
		 **/
		//function render(scene:IPixelScene,hotRender:Boolean = false):void;
		function render(scenes:Vector.<IPixelScene>):void;
	}
}