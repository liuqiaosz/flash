package pixel.texture
{
	import flash.display.JPEGEncoderOptions;
	import flash.display.JPEGXREncoderOptions;
	import flash.display.PNGEncoderOptions;

	public class PixelTextureEncodeEmu
	{
		public static const ENCODE_JPG:int = 1;
		public static const ENCODE_JPGXR:int = 2;
		public static const ENCODE_PNG:int = 3;
		
		public static const QUALITY_HIGHT:int = 4;
		public static const QUALITY_MID:int = 5;
		public static const QUALITY_LOW:int = 6;
		
		public static const PIXELENCODE_ARGB4444:int = 7;
		public static const PIXELENCODE_RGB555:int = 8;
		public static const PIXELENCODE_RGB565:int = 9;
		public static const PIXELENCODE_ARGB1555:int = 10;
		
		public static const ENCODER_API:int = 11;
		public static const ENCODER_PIXEL:int = 12;
		
		public static const QUALITY_JPGXR_HIGHT:int = 20;
		public static const QUALITY_JPGXR_MID:int = 40;
		public static const QUALITY_JPGXR_LOW:int = 90;
		
		public static const QUALITY_JPG_HIGHT:int = 90;
		public static const QUALITY_JPG_MID:int = 50;
		public static const QUALITY_JPG_LOW:int = 20;
		
		
		
		
		
		public static function getEncoder(type:int,quality:int = 0):Object
		{
			var qvalue:int = 0;
			switch(quality)
			{
				case QUALITY_HIGHT:
					qvalue = type == ENCODE_JPG ? QUALITY_JPG_HIGHT:QUALITY_JPGXR_HIGHT;
					break;
				case QUALITY_MID:
					qvalue = type == ENCODE_JPG ? QUALITY_JPG_MID:QUALITY_JPGXR_MID;
					break;
				case QUALITY_LOW:
					qvalue = type == ENCODE_JPG ? QUALITY_JPG_LOW:QUALITY_JPGXR_LOW;
					break;
			}
			switch(type)
			{
				case ENCODE_JPG:
					return new JPEGEncoderOptions(qvalue);
					break;
				case ENCODE_PNG:
					return new PNGEncoderOptions();
					break;
				case ENCODE_JPGXR:
					return new JPEGXREncoderOptions(qvalue);
					break;
			}
			return null;
		}
	}
}