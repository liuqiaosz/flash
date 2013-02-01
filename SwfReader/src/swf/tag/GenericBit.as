package swf.tag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import swf.ByteStream;

	public class GenericBit  extends GenericTag
	{
		protected var _BitFormat:int = 0;
		protected var _Width:int = 0;
		public function set BitmapWidth(Value:int):void
		{
			_Width = Value;
		}
		public function get BitmapWidth():int
		{
			return _Width;
		}
		protected var _Height:int = 0;
		public function set BitmapHeight(Value:int):void
		{
			_Height = Value;
		}
		public function get BitmapHeight():int
		{
			return _Height;
		}
		protected var _ColorTableSize:int = 0;
		protected var _BitmapBytes:ByteStream = null;
		public function set BitmapBytes(Value:ByteStream):void
		{
			_BitmapBytes = Value;
		}
		//protected var _ColorTableBytes:ByteStream = null;
		
		public function GenericBit(TagType:int,Stream:ByteStream = null)
		{
			super(TagType,Stream);
		}
		
		
		override public function Decode(Stream:ByteStream):void
		{
			_TagId = Stream.ReadUI16();
			
			if(_Type == Tag.LOSSLESS2)
			{
				_BitFormat = Stream.ReadUI8();
				_Width = Stream.ReadUI16();
				_Height = Stream.ReadUI16();
				if(_BitFormat == 3)
				{
					_ColorTableSize = Stream.ReadUI8();
					//读取色标
					//_ColorTableBytes = _BitmapBytes.ReadBytes(_ColorTableSize);
				}
				_BitmapBytes = Stream.ReadBytes();
				_BitmapBytes.Uncompress();
			}
			else if(_Type == Tag.DEFINEJPEG2)
			{
				_BitmapBytes = Stream.ReadBytes();
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
					var img:Bitmap = loader.content as Bitmap;
					trace(img);
				});
				
				loader.loadBytes(_BitmapBytes.Bytes);
				//trace("Len[" + _BitmapBytes.Length + "]");
			}
			
		}
		
		override public function Encode():ByteStream
		{
			super.Encode();
			Stream.WriteUI16(_TagId);
			Stream.WriteUI8(5);
			Stream.WriteUI16(_Width);
			Stream.WriteUI16(_Height);
			_BitmapBytes.Compress();
			Stream.WriteBytes(_BitmapBytes);
			return Stream;
		}
	}
}