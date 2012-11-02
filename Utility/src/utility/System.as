package utility
{
	import flash.system.Capabilities;

	public class System
	{
		public function System()
		{
		}

		private static var Os:String = Capabilities.os.substr(0, 3);
		
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
	}
}