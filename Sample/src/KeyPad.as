package
{
	import flash.ui.Keyboard;

	public class KeyPad
	{
		public static const PRESS:uint = 1;
		public static const RELEASE:uint = 0;
		public static const LEFT_UP:uint = 192;
		public static const RIGHT_UP:uint = 96;
		public static const LEFT_DOWN:uint = 144;
		public static const RIGHT_DOWN:uint = 48;
		
		public static const LEFT:uint = 128;
		public static const RIGHT:uint = 32;
		public static const UP:uint = 64;
		public static const DOWN:uint = 16;
		private var _value:uint = 0;
		
		private var _actValue:uint = 0;
		public function get value():uint
		{
			return _value;
		}
		
		public function get act():uint
		{
			return _actValue;
		}
		public function KeyPad()
		{
		}
		
		/**
		 * 键按下
		 **/
		public function set keyPress(keyCode:uint):void
		{
			switch(keyCode)
			{
				case Keyboard.LEFT:
					_value |= PRESS << 7;
					break;
				case Keyboard.RIGHT:
					_value |= PRESS << 5;
					break;
				case Keyboard.UP:
					_value |= PRESS << 6;
					break;
				case Keyboard.DOWN:
					_value |= PRESS << 4;
					break;
				case Keyboard.J:
					_actValue |= PRESS;
					break;
				case Keyboard.K:
					_actValue |= PRESS << 1;
					break;
			}
		}
		
		public static const ACT_J:uint = 1;
		public static const ACT_K:uint = 2;
		
		/**
		 * 键释放
		 **/
		public function set keyRelease(keyCode:uint):void
		{
			switch(keyCode)
			{
				case Keyboard.LEFT:
					_value ^= 128;
					break;
				case Keyboard.RIGHT:
					_value ^= 32;
					break;
				case Keyboard.UP:
					_value ^= 64;
					break;
				case Keyboard.DOWN:
					_value ^= 16;
					break;
				case Keyboard.J:
					_actValue ^= 1;
					break;
				case Keyboard.K:
					_actValue ^= 2;
					break;
			}
		}
	}
}