package swf.tag
{

	public class Tag
	{
		public static const LOSSLESS:int = 20;
		public static const LOSSLESS2:int = 36;
		public static const SYMBOLCLASS:int = 76;
		public static const DEFINESOUND:int = 14;
		public static const FILEATTR:int = 69;
		public static const SETBGCOLOR:int = 9;
		public static const DEFINEJPEG2:int = 21;
		public static const DEFINEJPEG3:int = 35;
		public static const DOABC:int = 82;
		public static function GetTagClassByType(Type:int):Class
		{
			switch(Type)
			{
				case LOSSLESS:
					return BitLossless;
				case SYMBOLCLASS:
					return SymbolClass;
				case LOSSLESS2:
					return BitLossless2;
				case DEFINEJPEG2:
					return BitJPEG2;
				case SETBGCOLOR:
					return SetBackgroundColor;
				case DEFINESOUND:
					return DefineSound;
				case FILEATTR:
					return FileAttribute;
					break;
				case DOABC:
					return DoABC;
					break;
				default:
					return null;
			}
		}
	}
}
