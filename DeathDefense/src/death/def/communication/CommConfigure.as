package death.def.communication
{
	public class CommConfigure
	{
		private static var _ip:String = "";
		private static var _port:int = 0;
		
		public static function set ip(value:String):void
		{
			_ip = value;
		}
		public static function get ip():String
		{
			return _ip;
		}
		
		public static function set port(value:int):void
		{
			_port = value;
		}
		public static function get port():int
		{
			return _port;
		}
		public static function CommConfigure()
		{
		}
	}
}