package pixel.utility
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	/**
	 * 图形处理工具
	 **/
	public class BitmapTools
	{
		public function BitmapTools()
		{
		}
		
		/**
		 * 透明边框剪裁
		 **/
		public static function CutAlpha(Source:BitmapData):BitmapData
		{
			var StartPoint:Point = new Point();
			//将像素数据保存成二维数组模式方便计算
			var IdxWidth:int = 0;
			var IdxHeight:int = 0;
			
			var HeightFlag:Boolean = false;
			var StartY:int = 0;
			var StartX:int = 0;
			var Pixel:uint = 0;
			var Pixels:Array = [];
			
			var EndX:int = 0;
			var EndY:int = 0;
			
			//第一次遍历获取左上角开始坐标
			for(IdxHeight=0; IdxHeight< Source.height; IdxHeight++)
			{
				Pixels[IdxHeight] = [];
				for(IdxWidth=0; IdxWidth < Source.width; IdxWidth++)
				{
					Pixel = Source.getPixel32(IdxWidth,IdxHeight);
					Pixels[IdxHeight][IdxWidth] = Pixel;
					if((Pixel >> 24 & 0xFF) != 0)
					{
						if(!HeightFlag)
						{
							StartY = IdxHeight;
							HeightFlag = true;
							StartX = IdxWidth;
						}
						StartX = IdxWidth < StartX ? IdxWidth:StartX;
						
						EndX = IdxWidth > EndX ? IdxWidth: EndX;
						EndY = IdxHeight > EndY ? IdxHeight: EndY;
					}
				}
			}
			var CuteBitmapData:BitmapData = new BitmapData (EndX - StartX,EndY - StartY);
			CuteBitmapData.copyPixels(Source,new Rectangle(StartX,StartY,CuteBitmapData.width,CuteBitmapData.height),new Point());
			return CuteBitmapData;
		}
		
		public static function BitmapClone(Source:BitmapData):BitmapData
		{
			var Data:BitmapData = new BitmapData(Source.width,Source.height,true,0);
			Data.copyPixels(Source,Source.rect,new Point());
			return Data;
		}
		
		public static function BitmapMirrorX(Source:Bitmap):void
		{
			var Mtx:Matrix = new Matrix();
			Mtx.scale(-1,1);
			Mtx.translate(Source.width,0);
			Source.transform.matrix = Mtx;
		}
		
		public static function BitmapMirrorY(Source:Bitmap):void
		{
			var Mtx:Matrix = new Matrix();
			Mtx.scale(1,-1);
			Mtx.translate(0,Source.height);
			Source.transform.matrix = Mtx;
		}
		
		public static function pixelsCompressToARGB4444(source:ByteArray):ByteArray
		{
			source.position = 0;
			var pixels:ByteArray = new ByteArray();
			//var source:ByteArray = bitmap.getPixels(bitmap.rect);
			var pixel:uint = 0;
			while(source.bytesAvailable > 0)
			{
				pixel = source.readUnsignedInt();
				pixel = ColorCode.ARGB8888ToARGB4444(pixel);
				pixels.writeShort(pixel);
			}
			return pixels;
		}
		
		public static function pixelsUncompressARGB4444ToARGB8888(source:ByteArray,fix:Boolean = true):ByteArray
		{
			source.position = 0;
			var pixels:ByteArray = new ByteArray();
			//var source:ByteArray = bitmap.getPixels(bitmap.rect);
			var pixel:uint = 0;
			
			while(source.bytesAvailable > 0)
			{
				pixel = source.readShort();
				pixel = ColorCode.ARGB4444ToARGB8888(pixel,fix).Pixel;
				pixels.writeUnsignedInt(pixel);
			}
			return pixels;
		}
		
		public static function pixelsCompressToRGB565(source:ByteArray):ByteArray
		{
			source.position = 0;
			var pixels:ByteArray = new ByteArray();
			//var source:ByteArray = bitmap.getPixels(bitmap.rect);
			var pixel:uint = 0;
			while(source.bytesAvailable > 0)
			{
				pixel = source.readUnsignedInt();
				pixel = ColorCode.RGB888ToRGB565(pixel);
				pixels.writeShort(pixel);
			}
			return pixels;
		}
		
		public static function pixelsUncompressRGB565ToRGB888(source:ByteArray,fix:Boolean = true):ByteArray
		{
			source.position = 0;
			var pixels:ByteArray = new ByteArray();
			//var source:ByteArray = bitmap.getPixels(bitmap.rect);
			var pixel:uint = 0;
			while(source.bytesAvailable > 0)
			{
				pixel = source.readShort();
				pixel = ColorCode.RGB565ToRGB888(pixel,fix).Pixel;
				pixels.writeUnsignedInt(pixel);
			}
			return pixels;
		}
		
		public static function pixelsCompressToRGB555(source:ByteArray):ByteArray
		{
			source.position = 0;
			var pixels:ByteArray = new ByteArray();
			//var source:ByteArray = bitmap.getPixels(bitmap.rect);
			var pixel:uint = 0;
			while(source.bytesAvailable > 0)
			{
				pixel = source.readUnsignedInt();
				pixel = ColorCode.RGB888ToRGB555(pixel);
				pixels.writeShort(pixel);
			}
			return pixels;
		}
		
		
		public static function BitmapEncodeToPNG(source:BitmapData):ByteArray
		{
			return source.encode(source.rect,new PNGEncoderOptions());
		}
		
		public static function GetAlpha(Pixel:uint):uint
		{
			return Pixel >> 24 & 0xFF;
		}
	}
}