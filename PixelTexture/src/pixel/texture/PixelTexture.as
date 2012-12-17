package pixel.texture
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	public class PixelTexture
	{
		private var _id:String = "";
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		private var _alphaCut:Boolean = false;
		public function set alphaCut(value:Boolean):void
		{
			_alphaCut = value;
		}
		public function get alphaCut():Boolean
		{
			return _alphaCut;
		}
		private var _compress:Boolean = false;
		public function set compress(value:Boolean):void
		{
			_compress = value;
		}
		public function get compress():Boolean
		{
			return _compress;
		}
		private var _pixelCompress:Boolean = false;
		public function set pixelCompress(value:Boolean):void
		{
			_pixelCompress = value;
		}
		public function get pixelCompress():Boolean
		{
			return _pixelCompress;
		}
		private var _pixelCompressOp:int = -1;
		public function set pixelCompressOp(value:int):void
		{
			_pixelCompressOp = value;
		}
		public function get pixelCompressOp():int
		{
			return _pixelCompressOp;
		}
		
		private var _imageWidth:int = 0;
		public function set imageWidth(value:int):void
		{
			_imageWidth = value;
		}
		public function get imageWidth():int
		{
			return _imageWidth;
		}
		
		private var _imageHeight:int = 0;
		public function set imageHeight(value:int):void
		{
			_imageHeight = value;
		}
		public function get imageHeight():int
		{
			return _imageHeight;
		}
		
		private var _source:ByteArray = null;
		public function set source(value:ByteArray):void
		{
			_source = value;
			_source.position = 0;
			if(_bitmap)
			{
				_bitmap.dispose();
				_bitmap = null;
			}
		}
		public function get source():ByteArray
		{
			return _source;
		}
		
		private var _bitmap:BitmapData = null;
		public function set bitmap(value:BitmapData):void
		{
			_bitmap = value;
			_imageWidth = _bitmap.width;
			_imageHeight = _bitmap.height;
		}
		public function get bitmap():BitmapData
		{
			if(!_bitmap)
			{
				if(_source)
				{
					if(_compress)
					{
						_source.uncompress();
					}
					_source.position = 0;
					_bitmap = new BitmapData(_imageWidth,_imageHeight);
					_bitmap.setPixels(_bitmap.rect,_source);
					dispose();
				}
			}
			
			return _bitmap;
		}
		
		private var _customAnchor:Boolean = false;
		public function set customAnchor(value:Boolean):void
		{
			_customAnchor = value;
		}
		public function get customAnchor():Boolean
		{
			return _customAnchor;
		}
		
		private var _anchor:Point = new Point();
		public function set anchor(value:Point):void
		{
			_anchor = value;
		}
		public function get anchor():Point
		{
			return _anchor;
		}
		
		public function PixelTexture(source:ByteArray = null)
		{
			_source = source;
		}
		
		public function dispose():void
		{
			if(_bitmap && _source)
			{
				_source.clear();
				_source = null;
			}
		}
	}
}