package bleach.cfg
{
	public class BleachSystem
	{
		private static var _instance:BleachSystem = null;
		private var _heartbeat:Number = 0;
		public function set heartbeat(value:Number):void
		{
			_heartbeat = value;
		}
		public function get heartbeat():Number
		{
			return _heartbeat;
		}
		
		private var _heartbeatot:Number = 0;
		public function set heartbeatot(value:Number):void
		{
			_heartbeatot = value;
		}
		public function get heartbeatot():Number
		{
			return _heartbeatot;
		}
		private var _host:String = "";
		public function set host(value:String):void
		{
			_host = value;
		}
		public function get host():String
		{
			return _host;
		}
		private var _port:int = 0;
		public function set port(value:int):void
		{
			_port = value;
		}
		public function get port():int
		{
			return _port;
		}
		
		private var _portal:int = 0;
		public function set portal(value:int):void
		{
			_portal = value;
		}
		public function get portal():int
		{
			return _portal;
		}
		
		private var _reConnectCount:int = 0;
		public function set reConnectCount(value:int):void
		{
			_reConnectCount = value;
		}
		public function get reConnectCount():int
		{
			return _reConnectCount;
		}
			
		public function BleachSystem()
		{
			if(null != _instance)
			{
				throw new Error("Singlton");
			}
		}
		
		public static function get instance():BleachSystem
		{
			if(null == _instance)
			{
				_instance = new BleachSystem();
			}
			return _instance;
		}
		
	}
}