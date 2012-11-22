package pixel.ui.control.asset
{
	import flash.display.Bitmap;

	public class AssetImage extends Asset implements IAsset
	{
		private var _image:Bitmap = null;
		public function get image():Bitmap
		{
			return _image;
		}
		
		public function AssetImage(name:String,image:Bitmap)
		{
			super(name);
			_image = image;
		}
		
		public function get width():int
		{
			if(_image)
			{
				return _image.width;
			}
			return 0;
		}
		public function get height():int
		{
			if(_image)
			{
				return _image.height;
			}
			return 0;
		}
	}
}