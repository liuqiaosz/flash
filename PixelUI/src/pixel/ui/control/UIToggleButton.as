package pixel.ui.control
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIToggleButtonStyle;
	import pixel.ui.control.utility.ButtonState;

	/**
	 * 可状态切换按钮
	 * 
	 * 
	 **/
	public class UIToggleButton extends UIControl implements IUIToggle
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
			selected = (ButtonState.TOGGLE_DOWN == _state);
		}
		
		private var _selected:Boolean = false;
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected)
			{
				var notify:UIControlEvent = new UIControlEvent(UIControlEvent.SELECTED,true);
				dispatchEvent(notify);
				state = ButtonState.TOGGLE_DOWN;
			}
			else
			{
				state = ButtonState.TOGGLE_UP;
			}
		}	
		public function get selected():Boolean
		{
			return _selected;
		}
		
		private var _value:String = "";
		public function set value(data:String):void
		{
			_value = data;
		}
		public function get value():String
		{
			return _value;
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeEventListener(MouseEvent.MOUSE_DOWN,onPressDown);
		}
		
		override protected function SpecialDecode(data:ByteArray):void
		{
			if(data.readByte() == 1)
			{
				_value = data.readUTF();
			}
			//_value = data.readUTF();
		}
		
		override protected function SpecialEncode(data:ByteArray):void
		{
			if(_value.length > 0)
			{
				data.writeByte(1);
				data.writeUTF(_value);
			}
			else
			{
				data.writeByte(0);
			}
		}
	}
}