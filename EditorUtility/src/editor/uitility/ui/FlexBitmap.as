package editor.uitility.ui
{
	import flash.display.Bitmap;
	
	import mx.core.UIComponent;

	public class FlexBitmap extends UIComponent
	{
		private var _Image:Bitmap = null;
		public function get Image():Bitmap
		{
			return _Image;
		}
		
		public function FlexBitmap(Img:Bitmap)
		{
			_Image = Img;
			addChild(_Image);
		}
	}
}