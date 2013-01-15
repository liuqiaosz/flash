package bleach.utils
{
	public class BleachConfig extends ShareDisk
	{
		public static const STR_MAIN_VER:String = "main_version";
		public static const STR_RSL_VER:String = "rsl_version";
		public static const STR_MSG_VER:String = "msg_version";
		
		public function BleachConfig()
		{
			super();	
		}
		
		public function get mainVersion():String
		{
			return this.getValue(STR_MAIN_VER);
		}
		public function get rslVersion():String
		{
			return this.getValue(STR_RSL_VER);
		}
		public function get msgVersion():String
		{
			return this.getValue(STR_MSG_VER); 
		}
	}
}