package pixel.tools.texture.utils
{
	import flash.filesystem.File;
	
	import pixel.utility.System;

	public class Common
	{
		public function Common()
		{
		}
		
		public static const INSTALL_DIR:String = File.applicationDirectory.nativePath + System.SystemSplitSymbol;
	}
}