package pixel.core
{
	import flash.display.BitmapData;

	public interface IPixelSprite extends IPixelNode
	{
		function get image():BitmapData;
	}
}