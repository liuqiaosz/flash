package pixel.message
{
	public class PixelMessage implements IPixelMessage
	{
		public static const FRAME_UPDATE:String = "FrameUpdate";
		public static const IO_KEYPRESSED:String = "KeyboardPressed";
		public static const IO_KEYRELEASE:String = "KeyboardRelease";
		
		private var _message:String = "";
		public function set message(value:String):void
		{
			_message = value;
		}
		public function get message():String
		{
			return _message;
		}
		
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		public function PixelMessage(msg:String)
		{
			_message = msg;
		}
	}
}