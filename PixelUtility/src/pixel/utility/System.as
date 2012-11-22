package pixel.utility
{
	import flash.system.Capabilities;

	public class System
	{
		public function System()
		{
		}

		private static var Os:String = Capabilities.os.substr(0, 3);
		private static var VersionStr:String = Capabilities.version.substr(4);
		private static var Vers:Array = VersionStr.split(",");
		private static var Ver:Version = new Version(parseInt(Vers[0]),parseInt(Vers[1]));
		//private static var major:int = parseInt(Vers[0]);
		//private static var minor:int = parseInt(Vers[1]);
		
		/**
		 * 
		 * 获取当前操作系统类型
		 * 
		 **/
		public static function get SystemType():uint
		{
			if(Os == "Win")
			{
				return SystemMode.WINDOWS;
			}
			else if(Os == "Mac")
			{
				return SystemMode.MAC;
			}
			else
			{
				return SystemMode.LINUX;
			}
		}
		
		public static function get SystemSplitSymbol():String
		{
			if(SystemType == SystemMode.WINDOWS)
			{
				return "\\";
			}
			else
			{
				return "/";
			}
		}
		
		public static function get playerVersion():Version
		{
			return Ver;
		}
		
		
	}
}