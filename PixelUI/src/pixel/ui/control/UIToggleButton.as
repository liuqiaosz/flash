package pixel.ui.control
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIToggleButtonStyle;
	import pixel.ui.control.utility.ButtonState;

	/**
	 * 可状态切换按钮
	 * 
	 * 
	 **/
	public class UIToggleButton extends UIControl
	{
		private var _state:int = ButtonState.TOGGLE_UP;
		public function set state(value:int):void
		{
			_state = value;
			switch(value)
			{
				case ButtonState.TOGGLE_DOWN:
					Style = _baseStyle.pressedStyle;
					break;
				case ButtonState.TOGGLE_UP:
					Style = _baseStyle;
					break;
			}
			Update();
		}
		public function get state():int
		{
			return _state;
		}
		
		private var _baseStyle:UIToggleButtonStyle = null;
		public function UIToggleButton()
		{
			super(UIToggleButtonStyle);
			//保存最初的样式
			_baseStyle = Style as UIToggleButtonStyle;
			addEventListener(MouseEvent.MOUSE_DOWN,onPressDown);
			this.buttonMode = true;
			width = 100;
			height = 40;
		}
		
		override public function EnableEditMode():void
		{
			this.buttonMode = false;
			super.EnableEditMode();
			removeEventListener(MouseEvent.MOUSE_DOWN,onPressDown);
		}
		
		override public function encode():ByteArray
		{
			var styleBak:IVisualStyle = Style;
			_Style = _baseStyle;
			var data:ByteArray = super.encode();
			_Style = styleBak;
			return data;
		}
		
		protected function onPressDown(event:MouseEvent):void
		{
			//变更按钮状态
			state = ButtonState.TOGGLE_DOWN == _state ? ButtonState.TOGGLE_UP : ButtonState.TOGGLE_DOWN;
		}
		
		override public function initializer():void
		{
			
		}
		
		override public function dispose():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,onPressDown);
		}
	}
}