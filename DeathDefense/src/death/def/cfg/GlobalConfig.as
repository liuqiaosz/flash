package death.def.cfg
{
	import pixel.utility.ShareDisk;
	import pixel.utility.ShareObjectHelper;

	public class GlobalConfig
	{
		public static const CFG_NAME:String = "bleach_global";
		public static const CFG_MAINVERSION:String = "main_version";
		public static const CFG_RSLVERSION:String = "rsl_version";
		public static const CFG_PARSEVERSION:String = "parse_version";
		public static const CFG_PARSER:String = "msg_parser";
		
		private static var _instance:GlobalConfig = new GlobalConfig();
		private var _disk:ShareDisk = null;
		public function GlobalConfig()
		{
			if(_instance)
			{
				throw new Error("");
			}
			_disk = ShareObjectHelper.findShareDisk(CFG_NAME);
		}
		
		//主程序版本
		public function get mainVersion():String
		{
			if(_disk)
			{
				return _disk.getValue(CFG_MAINVERSION);
			}
			return "";
		}
		
		//共享库版本
		public function get rslVersion():String
		{
			if(_disk)
			{
				return _disk.getValue(CFG_RSLVERSION);
			}
			return "";
		}
		
		//通讯解析库版本
		public function get parseVersion():String
		{
			if(_disk)
			{
				return _disk.getValue(CFG_PARSEVERSION);
			}
			return "";
		}
		
		//获取解析库path
		public function get messageParser():String
		{
			if(_disk)
			{
				return _disk.getValue(CFG_PARSER);
			}
			return "";
		}
		
		public static function get instance():GlobalConfig
		{
			return _instance;
		}
	}
}