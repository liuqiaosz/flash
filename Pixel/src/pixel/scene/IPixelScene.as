package pixel.scene
{
	import pixel.core.IPixelGeneric;
	import pixel.core.IPixelSprite;

	public interface IPixelScene extends IPixelGeneric
	{
		function reset():void;
		function get renderNodes():Vector.<IPixelSprite>;
	}
}