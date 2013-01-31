package pixel.ui.control.style
{
	import flash.utils.ByteArray;

	public class UIToggleButtonStyle extends UIStyle
	{
		private var _pressedStyle:UIStyle = null;
		public function get pressedStyle():UIStyle
		{
			return _pressedStyle;
		}
		public function UIToggleButtonStyle()
		{
			super();
			_pressedStyle = new UIStyle();
			_pressedStyle.BackgroundColor = 0x5d5d5d;
			_pressedStyle.BackgroundAlpha = 0.5;
		}
		
		override public function encode():ByteArray
		{
			var data:ByteArray = super.encode();
			var pressed:ByteArray = _pressedStyle.encode();
			data.writeBytes(pressed);
			return data;
		}
		override public function decode(data:ByteArray):void
		{
			super.decode(data);
			_pressedStyle.decode(data);
		}
	}
}