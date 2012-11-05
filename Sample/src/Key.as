package
{
	public class Key
	{
		private var _code:uint = 0;
		public function set code(value:uint):void
		{
			_code = value;
		}
		public function get code():uint
		{
			return _code;
		}
		
		private var _press:uint = 0;
		public function set press(value:uint):void
		{
			_press = value;
			_hold = true;
		}
		public function get press():uint
		{
			return _press;
		}
		private var _release:uint = 0;
		public function set release(value:uint):void
		{
			_release = value;
			_hold = false;
		}
		public function get release():uint
		{
			return _release;
		}
		private var _hold:Boolean = false;
		public function get hold():Boolean
		{
			return _hold;
		}
		public function Key()
		{
		}
	}
}