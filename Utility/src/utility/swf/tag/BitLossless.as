package utility.swf.tag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import utility.ColorCode;
	import utility.swf.ByteStream;

	public class BitLossless extends GenericBit
	{
		private var ColorMap:Vector.<uint> = null;
		//private var ColorPixel:ByteStream = null;
		private var ColorPixel:Vector.<int> = null;
		public function BitLossless(Stream:ByteStream = null)
		{
			super(Tag.LOSSLESS,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			
			_TagId = Stream.ReadUI16();
			_BitFormat = Stream.ReadUI8();
			_Width = Stream.ReadUI16();
			_Height = Stream.ReadUI16();
			if(_BitFormat == 3)
			{
				//_ColorTableSize = Stream.ReadUI8();
				_ColorTableSize = Stream.ReadUI8();
				trace("ColorTable [" + _ColorTableSize + "]");
				if(_ColorTableSize > 0)
				{
					var TotalSize:int = ((_ColorTableSize + 1) * 3) + (_Width * _Height);
					var ColorTable:ByteStream = Stream.ReadBytes();
					ColorTable.Uncompress();
					var BitData:BitmapData = new BitmapData(_Width,_Height);
					
					var Red:int = 0;
					var Green:int = 0;
					var Blue:int = 0;
					ColorMap = new Vector.<uint>();
					var Len:int = _ColorTableSize + 1;
					
					for(var Idx:int = 0; Idx<Len; Idx++)
					{
						Red = ColorTable.ReadUI8();
						Green = ColorTable.ReadUI8();
						Blue = ColorTable.ReadUI8();
						ColorMap[Idx] = ColorCode.ColorARGB(255,Red,Green,Blue);
						
						TotalSize -= 3;
					}
					
					ColorPixel = new Vector.<int>();
					while(TotalSize > 0)
					{
						ColorPixel.push(ColorTable.ReadUI8());
						TotalSize--;
					}

					trace("Width[" + _Width + "] Height[" + _Height + "]");
					trace("Bit Size[" + (_Width * _Height) + "]");
					trace("Map Size[" + ColorMap.length + "]");
					trace("Pixel[" + ColorPixel.length + "]");
					trace("Remain[" + ColorTable.Available + "]");
					trace("-------------------------------------");
				}
			}
			else if(_BitFormat == 4 || _BitFormat == 5)
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
				var Hidx:int = 0;
				var Widx:int = 0;
				
				var BitData:BitmapData = new BitmapData(_Width,_Height,true,0);
				var seek:int = 0;
				
				switch(_BitFormat)
				{
					case 3:
						if(ColorPixel)
						{
							BitData.lock();
							for(Hidx=0; Hidx<_Height; Hidx++)
							{
								for(Widx=0; Widx<_Width; Widx++)
								{
									var Index:int = ColorPixel[seek];
									if(Index >= 0 && Index < ColorMap.length)
									{
										BitData.setPixel32(Widx,Hidx,ColorMap[Index]);
									}
									else
									{
										BitData.setPixel32(Widx,Hidx,0x00FFFFFF);
									}
									seek++;
								}
							}
							BitData.unlock();
							_Image = new Bitmap(BitData);
						}
						break;
					default:
						var Pixels:ByteArray = _BitmapBytes.Bytes;
						Pixels.position = 0;
						Pixels.endian = Endian.BIG_ENDIAN;
						BitData.lock();
						for(Hidx=0; Hidx<_Height; Hidx++)
						{
							for(Widx=0; Widx<_Width; Widx++)
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
						break;
				}
				
				return _Image;
			}
			return null;
		}
	}
}