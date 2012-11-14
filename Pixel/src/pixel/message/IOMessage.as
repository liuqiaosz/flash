package pixel.message
{
	public class IOMessage extends PixelMessage
	{
		public static const KEYBOARD_INPUT:String = "KeyboardInput";
		private var _value:int = 0;
		public function set value(value:int):void
		{
			_value = value;
		}
		public function get value():int
		{
			return _value;
		}
		public function IOMessage(msg:String,target:Object)
		{
			super(msg,target);
		}
	}
}