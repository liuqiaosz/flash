package swf.tag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import swf.ByteStream;

	public class BitLossless2 extends GenericBit
	{
//		private var _BitFormat:int = 0;
//		private var _Width:int = 0;
//		public function set BitmapWidth(Value:int):void
//		{
//			_Width = Value;
//		}
//		public function get BitmapWidth():int
//		{
//			return _Width;
//		}
//		private var _Height:int = 0;
//		public function set BitmapHeight(Value:int):void
//		{
//			_Height = Value;
//		}
//		public function get BitmapHeight():int
//		{
//			return _Height;
//		}
//		private var _ColorTableSize:int = 0;
//		private var _BitmapBytes:ByteStream = null;
//		public function set BitmapBytes(Value:ByteStream):void
//		{
//			_BitmapBytes = Value;
//		}
//		private var _ColorTableBytes:ByteStream = null;
		
		public function BitLossless2(Stream:ByteStream = null)
		{
			super(Tag.LOSSLESS2,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			_TagId = Stream.ReadUI16();
			_BitFormat = Stream.ReadUI8();
			_Width = Stream.ReadUI16();
			_Height = Stream.ReadUI16();
			if(_BitFormat == 3)
			{
				_ColorTableSize = Stream.ReadUI8();
				//读取色标
				//_ColorTableBytes = _BitmapBytes.ReadBytes(_ColorTableSize);
			}
			else
			{
				_BitmapBytes = Stream.ReadBytes();
				_BitmapBytes.Uncompress();
			}
		}
		private var _Image:Bitmap = null;
		override public function get Source():Object
		{
			if(_Image)
			{
				return _Image;
			}
			if(_Width > 0 && _Height > 0)
			{
				var BitData:BitmapData = new BitmapData(_Width,_Height);
				var Pixels:ByteArray = _BitmapBytes.Bytes;
				Pixels.position = 0;
				Pixels.endian = Endian.BIG_ENDIAN;
				BitData.lock();
				for(var Hidx:int=0; Hidx<_Height; Hidx++)
				{
					for(var Widx:int=0; Widx<_Width; Widx++)
					{
						//var color:uint = Pixels.readByte() | Pixels.readByte()| Pixels.readByte() | Pixels.readByte();
						BitData.setPixel32(Widx,Hidx,Pixels.readUnsignedInt());
					}
				}
				BitData.unlock();
				//				while(Pixels.bytesAvailable > 0)
				//				{
				//					BitData.
				//				}
				
				//Pixels.readInt();
				//BitData.setPixels(BitData.rect,Pixels);
				_Image = new Bitmap(BitData);
				return _Image;
			}
			return null;
		}
//		override public function Decode(Stream:ByteStream):void
//		{
//			_Id = Stream.ReadUI16();
//			_BitFormat = Stream.ReadUI8();
//			_Width = Stream.ReadUI16();
//			_Height = Stream.ReadUI16();
//			if(_BitFormat == 3)
//			{
//				_ColorTableSize = Stream.ReadUI8();
//				//读取色标
//				_ColorTableBytes = _BitmapBytes.ReadBytes(_ColorTableSize);
//			}
//			_BitmapBytes = Stream.ReadBytes();
//			_BitmapBytes.Uncompress();
//		}
//		
//		
//		
//		override public function Encode():ByteStream
//		{
//			super.Encode();
//			Stream.WriteUI16(_Id);
//			Stream.WriteUI8(5);
//			Stream.WriteUI16(_Width);
//			Stream.WriteUI16(_Height);
//			_BitmapBytes.Compress();
//			Stream.WriteBytes(_BitmapBytes);
//			return Stream;
//		}
//		
//		public function get Image():Bitmap
//		{
//			if(_Width > 0 && _Height > 0)
//			{
//				var BitData:BitmapData = new BitmapData(_Width,_Height);
//				var Pixels:ByteArray = _BitmapBytes.Bytes;
//				Pixels.position = 0;
//				Pixels.endian = Endian.BIG_ENDIAN;
//				BitData.lock();
//				for(var Hidx:int=0; Hidx<_Height; Hidx++)
//				{
//					for(var Widx:int=0; Widx<_Width; Widx++)
//					{
//						//var color:uint = Pixels.readByte() | Pixels.readByte()| Pixels.readByte() | Pixels.readByte();
//						BitData.setPixel32(Widx,Hidx,Pixels.readUnsignedInt());
//					}
//				}
//				BitData.unlock();
////				while(Pixels.bytesAvailable > 0)
////				{
////					BitData.
////				}
//				
//				//Pixels.readInt();
//				//BitData.setPixels(BitData.rect,Pixels);
//				return new Bitmap(BitData);
//			}
//			return null;
//		}
	}
}