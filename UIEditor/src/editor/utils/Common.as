package editor.utils
{
	import flash.filesystem.File;
	
	import utility.System;

	public class Common
	{
		//输出目录
		public static const OUTPUT:String = File.applicationDirectory.nativePath + System.SystemSplitSymbol + "Output" + System.SystemSplitSymbol;
		public static const MODEL:String = OUTPUT + "Model" + System.SystemSplitSymbol;
		public static const ASSETLIB:String = OUTPUT + "AssetLibrary" + System.SystemSplitSymbol;
		public static const PACKAGE:String = "ui";
		public static const ASSETS:String = OUTPUT + "assets" + System.SystemSplitSymbol;
		public static const CORECOMPACK:String = "corecom.control.*;\n import corecom.control.asset.ControlAssetManager;\n";
		public static const INSTALL_DIR:String = File.applicationDirectory.nativePath + System.SystemSplitSymbol;
		public static const PREFERENCE:String = "Preference.cfg";
		public static const ASSL:String = ".assl";
		
		public static const TEXT_ERRORTIP:String = "错误提示";
		public function Common()
		{
		}
	}
}