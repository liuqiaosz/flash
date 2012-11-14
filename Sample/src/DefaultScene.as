package
{
	import flash.display.Bitmap;
	
	import pixel.core.IPixelSprite;
	import pixel.core.PixelSprite;
	import pixel.scene.PixelScene;

	public class DefaultScene extends PixelScene
	{
		[Embed(source="assets/map2.jpg")]
		private var Img:Class;
		public function DefaultScene()
		{
			super();
			var b:Bitmap = new Img() as Bitmap;
			var sp:IPixelSprite = new PixelSprite(b.bitmapData);
			
			addNode(sp);
		}
	}
}