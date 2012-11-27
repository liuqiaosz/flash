package pixel.particle
{
	import flash.display.Bitmap;

	/**
	 * 图形粒子
	 */
	public class PixelBitmapParticle extends PixelParticle implements IPixelParticle
	{
		protected var _image:Bitmap = null;
		public function PixelBitmapParticle(image:Bitmap,health:int = 0,radian:Number = 0)
		{
			_image = image;
			super(0,0,health,radian);
		}
		
		override public function update():void
		{
		}
		override public function render():void
		{
			_draw.clear();
			_draw.beginBitmapFill(_image.bitmapData,null,false,true);
			_draw.drawRect(0,0,_image.width,_image.height);
			_draw.endFill();
		}
	}
}