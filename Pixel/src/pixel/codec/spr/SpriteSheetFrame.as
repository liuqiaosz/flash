package pixel.codec.spr
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import pixel.codec.ICoder;

	/**
	 * 帧数据
	 **/
	public class SpriteSheetFrame implements ICoder
	{
		//帧数据
		private var _Bitmap:BitmapData = null;
		public function set Bitmap(Value:BitmapData):void
		{
			_Bitmap = Value;
		}
		public function get Bitmap():BitmapData
		{
			return _Bitmap;
		}
		
		//偏移锚点
		private var _OffsetAnchor:Point = new Point();
		public function set OffsetAnchor(Value:Point):void
		{
			_OffsetAnchor = Value;
		}
		public function get OffsetAnchor():Point
		{
			return _OffsetAnchor;
		}
		
		//帧序列号
		private var _Index:uint = 0;
		public function set Index(Value:uint):void
		{
			_Index = Value;
		}
		public function get Index():uint
		{
			return _Index;
		}
		
		public function SpriteSheetFrame()
		{
		}
		
		public function encode():ByteArray
		{
			
			var Data:ByteArray = new ByteArray();
			Data.writeByte(_Index);
			Data.writeShort(_OffsetAnchor.x);
			Data.writeShort(_OffsetAnchor.y);
			Data.writeShort(_Bitmap.width);
			Data.writeShort(_Bitmap.height);
			var Pixels:ByteArray = _Bitmap.getPixels(_Bitmap.rect);
			Pixels.compress();
			//Tools.ByteCompress(Pixels);
			Data.writeShort(Pixels.length);
			Data.writeBytes(Pixels,0,Pixels.length);
			return Data;
		}
		
		public function decode(Data:ByteArray):void
		{
			_Index = Data.readByte();
			_OffsetAnchor.x = Data.readShort();
			_OffsetAnchor.y = Data.readShort();
			var Width:int = Data.readShort();
			var Height:int = Data.readShort();
			var Pixels:ByteArray = new ByteArray();
			var Len:uint = Data.readShort();
			Data.readBytes(Pixels,0,Len);
			Pixels.uncompress();
			_Bitmap = new BitmapData(Width,Height);
			_Bitmap.setPixels(_Bitmap.rect,Pixels);
//			Tools.ByteUncompress(Pixels);
//			var Encoder:PNGEncoder = new PNGEncoder();
//			
//			Pixels = Encoder.encodeByteArray(Pixels,Width,Height);
//			_Bitmap = new BitmapData(Width,Height);
//			_Bitmap.setPixels(_Bitmap.rect,Pixels);
		}
	}
}