package mapassistant.util
{
	import flash.filesystem.File;
	
	import utility.ColorCode;
	import utility.System;
	
	public class Common
	{
		public static const OUTPUT:String = File.applicationDirectory.nativePath + System.SystemSplitSymbol;
		public static const RESOURCE:String = OUTPUT + "Resources" + System.SystemSplitSymbol;
		public static const SYMBOL:String = OUTPUT + "Symbol" + System.SystemSplitSymbol;
		public static const MAP:String = OUTPUT + "Map" + System.SystemSplitSymbol;
		public static const MAPDATABINSUFFIX:String = ".md";
		public static const MAPDATAXMLSUFFIX:String = ".xml";
		
		public static const COLOR_WALK:uint = ColorCode.GREEN;
		public static const COLOR_CREATOR:uint = ColorCode.ORANGE;
		
		public static const AREAPARTITION_YES:uint = 1;
		public static const AREAPARTITION_NO:uint = 0;
		
		public static const BYTE_CHAR_END:uint = 32;
		public function Common()
		{
		}
	}
}