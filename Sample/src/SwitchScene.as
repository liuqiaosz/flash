package
{
	import flash.display.Bitmap;
	
	import pixel.core.IPixelSprite;
	import pixel.core.PixelSprite;
	import pixel.core.PixelLayer;

	public class SwitchScene extends PixelLayer
	{
		[Embed(source="assets/map1.jpg")]
		private var Img:Class;
		
		public function SwitchScene()
		{
			super();
			var b:Bitmap = new Img() as Bitmap;
			var sp:IPixelSprite = new PixelSprite(b.bitmapData);
			
			addNode(sp);
		}
	}
}