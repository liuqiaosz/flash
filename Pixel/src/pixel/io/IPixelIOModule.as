package pixel.io
{
	import pixel.scene.IPixelScene;

	public interface IPixelIOModule
	{
		function addSceneToScreen(scene:IPixelScene):void;
		function removeSceneFromScreen(scene:IPixelScene):void;
		//function get screenScenes():Vector.<IPixelScene>;
		function screenRefresh(scenes:Vector.<IPixelScene>):void;
	}
}