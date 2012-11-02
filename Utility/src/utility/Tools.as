package utility
{
	import com.hurlant.crypto.hash.MD5;
	import com.hurlant.util.Hex;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	public class Tools
	{
		public function Tools()
		{
			
		}
		
		/**
		 * 颜色值抓换成16进制字符串
		 **/
		public static function Color2Hex(Color:uint):String
		{
			if(Color == 0)
			{
				return "#000000";
			}
			var Value:String="000000" + Color.toString(16).toUpperCase();
			return "#"+Value.substr(Value.length-6);
		}
		
		public static function MD5Encode(Source:ByteArray):String
		{
			var Encoder:MD5 = new MD5();
			var Result:ByteArray = Encoder.hash(Source);
			Result.position = 0;
			
			return Hex.fromArray(Result);
		}
		
		/**
		 * 获取对象全路径包名
		 **/
		public static function GetPackage(Source:*):String
		{
			var URI:String = getQualifiedClassName(Source);
			return URI.substr(0,URI.indexOf(":"));
		}
		
		public static function ClassSimpleName(Source:*):String
		{
			var URI:String = getQualifiedClassName(Source);
			return URI.substring(URI.lastIndexOf(":") + 1);
		}
		
		/**
		 * 字符串填充
		 **/
		public static function FillChar(Source:String,Char:String,MaxLen:int,Dir:uint = 0):String
		{
			var Value:String = Source;
			var Len:int = Value.length;
			while(Len<MaxLen)
			{
				if(Dir == 0)
				{
					Value = Char + Value;
				}
				else
				{
					Value += Char;
				}
				Len = Value.length;
			}
			
			
			return Value;
		}
		
		public static function BitmapScale(Source:BitmapData,Size:int):BitmapData
		{
			var Scale:Number = Source.width > Source.height ? 
				(Source.width > Size ? Size /Source.width : 1) : 
				(Source.height > Size ? Size /Source.height : 1);
			
			var PreviewData:BitmapData = new BitmapData(Source.width * Scale,Source.height * Scale);
			var Mtx:Matrix = new Matrix();
			Mtx.scale(Scale,Scale);
			PreviewData.draw(Source,Mtx);
			return PreviewData;
		}
		
		public static function BitmapClone(Source:Bitmap):Bitmap
		{
			var NewData:BitmapData = BitmapDataClone(Source.bitmapData);
			return new Bitmap(NewData);
		}
		public static function BitmapDataClone(Source:BitmapData):BitmapData
		{
			var NewData:BitmapData = new BitmapData(Source.width,Source.height);
			NewData.copyPixels(Source,Source.rect,new Point());
			
			return NewData;
		}
		
		public static function ByteUncompress(Source:ByteArray):void
		{
			var Pos:int = Source.position;
			
			var UnzipData:ByteArray = new ByteArray();
			Source.readBytes(UnzipData);
			UnzipData.uncompress();
			
			Source.position = Pos;
			Source.writeBytes(UnzipData);
			Source.position = Pos;
		}
		
		public static function ByteCompress(Source:ByteArray):void
		{
			var Pos:int = Source.position;
			var zipData:ByteArray = new ByteArray();
			Source.readBytes(zipData,Pos,Source.bytesAvailable);
			zipData.compress();
			Source.position = Pos;
			Source.writeBytes(zipData);
			Source.position = Pos;
		}
		
		public static function ByteFinder(Source:ByteArray,Char:uint):uint
		{
			var OldPosition:uint = Source.position;
			var Pos:uint = 0;
			while(Source.readByte() != Char)
			{
				Pos++;
			}
			
			Source.position = OldPosition;
			return Pos;
		}
		
		public static function ReplaceAll(Source:String,Target:String,Value:String):String
		{
			var Reg:RegExp = new RegExp(Target,"g");
			return Source.replace(Reg,Value);
		}
		
		public static function StringActualLength(Value:String):int
		{
			var Byte:ByteArray = new ByteArray();
			Byte.writeMultiByte(Value,"");
			var Len:int = Byte.length;
			Byte.clear();
			return Len;
		}
		
		/**
		 * 百分比计算
		 **/
		public static function TransPercent(Value:int,Total:int):int
		{
			if(Value >= Total)
			{
				return 100;
			}
			return (Total / Value) * 100;
		}
		
		/**
		 * 图片9宫格处理
		 * 
		 * 
		 **/
		public static function ScaleBitmap9Grid(Image:Bitmap,Left:int,Top:int,Right:int,Bottom:int):Vector.<Rectangle>
		{
			var Vec:Vector.<Rectangle> = new Vector.<Rectangle>();
			
			var Rect:Rectangle = new Rectangle();
			
			Rect.x = 0;
			Rect.y = 0;
			Rect.width = Left;
			Rect.height = Top;
			Vec.push(Rect);
			Rect = new Rectangle();
			//LeftTop = GetBitmap(0,0,Left,Top);
			//addChild(LeftTop);
			//LeftCenter = GetBitmap(0,Top,Left,(Source.height - Top - Bottom));
			Rect.x = 0;
			Rect.y = Top;
			Rect.width = Left;
			Rect.height = (Image.height - Top - Bottom);
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//addChild(LeftCenter);
			//LeftBottom = GetBitmap(0,Top + LeftCenter.height,Left,Bottom);
			Rect.x = 0;
			Rect.y = (Image.height - Top - Bottom);
			Rect.width = Left;
			Rect.height = Bottom;
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//CenterTop = GetBitmap(Left,0,(Source.width - Left - Right),Top);
			Rect.x = Left;
			Rect.y = 0;
			Rect.width = (Image.width - Left - Right);
			Rect.height = Top;
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//addChild(CenterTop);
			//Center = GetBitmap(Left,Top,CenterTop.width,LeftCenter.height);
			Rect.x = Left;
			Rect.y = Top;
			Rect.width = (Image.width - Left - Right);
			Rect.height = (Image.height - Top - Bottom);
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//addChild(Center);
			//CenterBottom = GetBitmap(Left,Center.y + Center.height,CenterTop.width,Bottom);
			Rect.x = Left;
			Rect.y = Top + (Image.height - Top - Bottom);
			Rect.width = (Image.width - Left - Right);
			Rect.height = Bottom;
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//RightTop = GetBitmap(CenterTop.x + CenterTop.width,0,Right,Top);
			Rect.x = Left + (Image.width - Left - Right);
			Rect.y = 0;
			Rect.width = Right;
			Rect.height = Top;
			Vec.push(Rect);
			Rect = new Rectangle();
			
			//addChild(RightTop);
			//RightCenter = GetBitmap(RightTop.x,Top,Right,Center.height);
			Rect.x = Left + (Image.width - Left - Right);
			Rect.y = Top;
			Rect.width = Right;
			Rect.height = (Image.height - Top - Bottom);
			Vec.push(Rect);
			Rect = new Rectangle();
			//addChild(RightCenter);
			//RightBottom = GetBitmap(RightTop.x,RightCenter.y + RightCenter.height,Right,Bottom);
			Rect.x = Left + (Image.width - Left - Right);
			Rect.y = Top + (Image.height - Top - Bottom);
			Rect.width = Right;
			Rect.height = Bottom;
			Vec.push(Rect);

			return Vec;
		}
	}
}