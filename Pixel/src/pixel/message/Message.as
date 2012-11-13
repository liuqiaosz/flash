package pixel.message
{
	public class Message
	{
		
		private var _message:String = "";
		public function set message(value:String):void
		{
			_message = value;
		}
		public function get message():String
		{
			return _message;
		}
		private var _target:Object = null;
		public function get target():Object
		{
			return _target;
		}
		public function set target(value:Object):void
		{
			_target = value;
		}
		public function Message()
		{
		}
	}
}