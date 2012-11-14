package
{
	import flash.display.Bitmap;
	
	import pixel.core.IPixelSprite;
	import pixel.core.PixelSprite;
	import pixel.scene.PixelScene;

	public class SwitchScene extends PixelScene
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