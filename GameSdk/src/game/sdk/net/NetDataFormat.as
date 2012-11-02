package game.sdk.net
{
	import flash.net.URLLoaderDataFormat;

	public class NetDataFormat
	{
		public static const XML:uint = 0;
		public static const JSON:uint = 1;
		public static const HTTP_BINARY:String = URLLoaderDataFormat.BINARY;
		public static const HTTP_TEXT:String = URLLoaderDataFormat.TEXT;
		public static const HTTP_VAR:String = URLLoaderDataFormat.VARIABLES;
		//public static const HTTP_IMAGE_PNG:String = "PNG";
		//public static const HTTP_IMAGE_JPG:String = "JPG";
		//public static const HTTP_SWF:String = "SWF";
		public function NetDataFormat()
		{
		}
	}
}