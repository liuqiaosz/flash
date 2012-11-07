package mapassistant.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	
	import utility.IClone;
	import utility.IDispose;

	public class FlexImage extends UIComponent implements IDispose,IClone
	{
		private var _Image:Bitmap = null;
		public function FlexImage(ImageData:Bitmap)
		{
			_Image = ImageData;
			addChild(_Image);
			width = _Image.width;
			height = _Image.height;
		}
		
		public function get Image():Bitmap
		{
			return _Image;
		}
		public function Clone():Object
		{
			return new FlexImage(new Bitmap(_Image.bitmapData.clone()));
		}
		
		public function Dispose():void
		{
			if(_Image)
			{
				_Image.bitmapData.dispose();
			}
		}
		
	}
}