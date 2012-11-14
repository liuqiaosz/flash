package pixel.core
{
	import flash.display.BitmapData;
	
	import pixel.codec.spr.SpriteSheetFrame;

	public interface IPixelSpriteSheet extends IPixelSprite
	{
		function get imageSheet():Vector.<SpriteSheetFrame>;
	}
}