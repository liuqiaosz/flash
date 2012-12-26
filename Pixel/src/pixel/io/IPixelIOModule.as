package pixel.io
{
	import pixel.core.IPixelLayer;

	public interface IPixelIOModule
	{
		function addSceneToScreen(scene:IPixelLayer):void;
		function removeSceneFromScreen(scene:IPixelLayer):void;
		//function get screenScenes():Vector.<IPixelScene>;
		function screenRefresh(scenes:Vector.<IPixelLayer>):void;
	}
}