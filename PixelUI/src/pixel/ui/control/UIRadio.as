package pixel.ui.control
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIRadioStyle;

	public class UIRadio extends UIControl
	{
		private var _value:String = "";
		public function set value(data:String):void
		{
			_value = data;
		}
		public function get value():String
		{
			return _value;
		}
			
		private var _label:UITextBase = null;
		private var _isFocus:Boolean = false;
		private var _selected:Boolean = false;
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			Update();
			if(_selected)
			{
				var notify:UIControlEvent = new UIControlEvent(UIControlEvent.SELECTED,true);
				dispatchEvent(notify);
			}	
		}
		
		public function get label():UITextBase
		{
			return _label;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		private var _inlineSize:int = 2;
		public function set inlineSize(value:int):void
		{
			_inlineSize = value;
			Update();
		}
		public function get inlineSize():int
		{
			return _inlineSize;
		}
		private var _frameSize:int = 6;
		public function set frameSize(value:int):void
		{
			_frameSize = value;
			width = height = (_frameSize * 2) + _label.width;
			Update();
		}
		public function get frameSize():int
		{
			return _frameSize;
		}
		
		public function set selectColor(value:uint):void
		{
			UIRadioStyle(_Style).selectColor = value;
			Update();
		}
		public function get selectColor():uint
		{
			return UIRadioStyle(_Style).selectColor;
		}
		
		public function set focusColor(value:uint):void
		{
			UIRadioStyle(_Style).focusColor = value;
			Update();
		}
		public function get focusColor():uint
		{
			return UIRadioStyle(_Style).focusColor
		}
		public function set focusAlpha(value:Number):void
		{
			UIRadioStyle(_Style).focusAlpha = value;
			Update();
		}
		public function get focusAlpha():Number
		{
			return UIRadioStyle(_Style).focusAlpha
		}
			
		public function UIRadio(skin:Class = null)
		{
			super(skin ? skin : UIRadioStyle);
			this.addEventListener(MouseEvent.MOUSE_MOVE,onRadioFocus);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onRadioPressed);
			this.addEventListener(MouseEvent.MOUSE_OUT,onRadioFocusOut);
			
			_label = new UITextBase();
			_label.width = 50;
			_label.height = _frameSize * 2;
			
			height = (_frameSize * 2);
			width = _frameSize * 2 + _label.width + 2;
			addChild(_label);
			_label.x = _frameSize * 2 + 2;
		}
		
		override public function dispose():void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onRadioFocus);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onRadioPressed);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onRadioFocusOut);
		}
		
		override public function EnableEditMode():void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onRadioFocus);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onRadioPressed);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onRadioFocusOut);
			_selected = true;
			super.EnableEditMode();
			this.mouseChildren = false;
			_isFocus = true;
			//this.mouseEnabled = false;
		}
		
		protected function onRadioPressed(event:MouseEvent):void
		{
			if(!_selected)
			{
				selected = true;
			}
		}
		
		protected function onRadioFocusOut(event:MouseEvent):void
		{
			_isFocus = false;
			Update();
		}
		protected function onRadioFocus(event:MouseEvent):void
		{
			_isFocus = true;
			Update();
		}
		
		override protected function StyleRender(Style:IVisualStyle):void
		{
			var style:UIRadioStyle = Style as UIRadioStyle;
			var pen:Graphics = this.graphics;
			pen.clear();
			//绘制外框
			pen.lineStyle(style.BorderThinkness,style.BorderColor,style.BorderAlpha);
			if(_isFocus)
			{
				pen.beginFill(style.focusColor,style.focusAlpha);
			}
			else
			{
				pen.beginFill(0xffffff);
			}
			pen.drawCircle(_frameSize,_frameSize,_frameSize);
			pen.endFill();
			
			//绘制内框
			if(_selected)
			{
				//屏蔽内框线条
				pen.lineStyle(0,style.selectColor,0);
				pen.beginFill(style.selectColor);
				pen.drawCircle(_frameSize,_frameSize,_inlineSize);
				pen.endFill();
			}
			
			_label.x = _frameSize * 2 + 2;
			_label.y = ((_frameSize * 2) - _label.height) * 0.5;
			_label.y = _label.y < 0 ? 0: _label.y;
		}
		
		override protected function SpecialDecode(data:ByteArray):void
		{
			_frameSize = data.readShort();
			_inlineSize = data.readShort();
			_value = data.readUTF();
			data.readByte();
		
			_label.decode(data);
		}
		
		override protected function SpecialEncode(data:ByteArray):void
		{
			data.writeShort(_frameSize);
			data.writeShort(_inlineSize);
			data.writeUTF(_value);
			var labelData:ByteArray = _label.encode();
			data.writeBytes(labelData);
		}
	}
}