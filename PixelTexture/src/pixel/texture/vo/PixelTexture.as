package pixel.texture.vo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	import pixel.texture.PixelTextureEncodeEmu;
	import pixel.texture.PixelTextureFactory;
	import pixel.texture.PixelTextureNS;
	import pixel.utility.BitmapTools;
	
	use namespace PixelTextureNS;
	
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
		
		//透明剪裁
		private var _alphaCut:Boolean = false;
		public function set alphaCut(value:Boolean):void
		{
			_alphaCut = value;
		}
		public function get alphaCut():Boolean
		{
			return _alphaCut;
		}
		//图形size
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
		
		//有损像素压缩类型
		private var _pixelCompressOp:int = 0;
		public function set pixelCompressOp(value:int):void
		{
			_pixelCompressOp = value;
		}
		public function get pixelCompressOp():int
		{
			return _pixelCompressOp;
		}
		
		//是否开启编码
		private var _encoderEnabled:Boolean = false;
		public function set encoderEnabled(value:Boolean):void
		{
			_encoderEnabled = value;
		}
		public function get encoderEnabled():Boolean
		{
			return _encoderEnabled;
		}
		
		private var _encoder:int = 0;
		public function set encoder(value:int):void
		{
			_encoder = value;
		}
		public function get encoder():int
		{
			return _encoder;
		}
		
		private var _encodeType:int = 0;
		public function set encodeType(value:int):void
		{
			_encodeType = value;
		}
		public function get encodeType():int
		{
			return _encodeType;
		}
		
		private var _encodeQuality:int = 0;
		public function set encodeQuality(value:int):void
		{
			_encodeQuality = value;
		}
		public function get encodeQuality():int
		{
			return _encodeQuality;
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
				_bitmap = new BitmapData(_imageWidth,_imageHeight,true,0);
				if(_source)
				{
					_source.position = 0;
					if(_encoderEnabled)
					{
						switch(_encoder)
						{
							case PixelTextureEncodeEmu.ENCODER_API:
								PixelTextureFactory.instance.asyncLoadTexture(this);
								break;
							case PixelTextureEncodeEmu.ENCODER_PIXEL:
								var pixels:ByteArray = null;
								_source.uncompress(CompressionAlgorithm.LZMA);
								switch(_pixelCompressOp)
								{
									case PixelTextureEncodeEmu.PIXELENCODE_RGB565:
										pixels = BitmapTools.pixelsUncompressRGB565ToRGB888(_source);
										break;
									case PixelTextureEncodeEmu.PIXELENCODE_ARGB4444:
										pixels = BitmapTools.pixelsUncompressARGB4444ToARGB8888(_source);
										break;
								}
								if(pixels.length > 0)
								{
									_bitmap.setPixels(_bitmap.rect,pixels);
								}
								break;
						}
					}
					else
					{
						_bitmap.setPixels(_bitmap.rect,_source);
					}
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
			if(_bitmap)
			{
				_bitmap.dispose();
				_bitmap = null;
			}
		}
		
//		public function encode():ByteArray
//		{
//			var data:ByteArray = new ByteArray();
//			data.writeByte(_id.length);
//			data.writeUTFBytes(_id);
//			data.writeShort(_imageWidth);
//			data.writeShort(_imageHeight);
//			//data.writeByte(int(_compress));
//			
//			data.writeByte(int(_customAnchor));
//			if(_customAnchor)
//			{
//				data.writeShort(_anchor.x);
//				data.writeShort(_anchor.y);
//			}
//			
//			var pixels:ByteArray = _source ? _source:bitmap.getPixels(bitmap.rect);
////			if(_compress)
////			{
////				pixels.compress(CompressionAlgorithm.LZMA);	
////			}
//			data.writeInt(pixels.length);
//			data.writeBytes(pixels);
//			return data;
//		}
		
//		public function decode(data:ByteArray):void
//		{
//			var len:int = data.readByte();
//			_id = data.readUTFBytes(len);
//			_imageWidth = data.readShort();
//			_imageHeight = data.readShort();
//			//_compress = Boolean(data.readByte());
//			
//			_customAnchor = Boolean(data.readByte());
//			if(_customAnchor)
//			{
//				_anchor.x = data.readShort();
//				_anchor.y = data.readShort();
//			}
//			
//			len = data.readInt();
//			_source = new ByteArray();
//			data.readBytes(_source,0,len);
//		}
	}
}