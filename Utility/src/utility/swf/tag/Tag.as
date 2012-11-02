package utility.swf.tag
{
	import flash.utils.Dictionary;

	public class Tag
	{
		public static const LOSSLESS:int = 20;
		public static const LOSSLESS2:int = 36;
		public static const SYMBOLCLASS:int = 76;
		public static const DEFINESOUND:int = 14;
		public static const FILEATTR:int = 69;
		public static const SETBGCOLOR:int = 9;
		public static const DEFINEJPEG2:int = 21;
		public static function GetTagClassByType(Type:int):Class
		{
			switch(Type)
			{
				case 20:
					return BitLossless;
				case 76:
					return SymbolClass;
				case 36:
					return BitLossless2;
				case DEFINEJPEG2:
					return BitJPEG2;
				case SETBGCOLOR:
					return SetBackgroundColor;
				case DEFINESOUND:
					return DefineSound;
				case FILEATTR:
					return FileAttribute;
				default:
					return null;
			}
		}
	}
}
