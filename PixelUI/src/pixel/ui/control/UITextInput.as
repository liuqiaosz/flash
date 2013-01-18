package pixel.ui.control
{
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.engine.TextElement;
	
	import pixel.ui.control.style.UITextInputStyle;
	import pixel.ui.core.PixelUINS;
	
	use namespace PixelUINS;
	
	public class UITextInput extends UITextBase
	{
		public function UITextInput(Text:String = "",Skin:Class = null)
		{
			super(Skin?Skin:UITextInputStyle,Text);
			width = 100;
			height = 20;
			this.Input = true;
		}
		
		override public function initializer():void
		{
//			addEventListener(FocusEvent.FOCUS_IN,Focus);
//			addEventListener(FocusEvent.FOCUS_OUT,FocusLeave);
		}
		
		override public function dispose():void
		{
//			removeEventListener(FocusEvent.FOCUS_IN,Focus);
//			removeEventListener(FocusEvent.FOCUS_OUT,FocusLeave);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_TextField.width = value;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			_TextField.height = value;
		}
		
//		private var _pwd:Boolean = false;
//		public function set isPassword(value:Boolean):void
//		{
//			_TextField.displayAsPassword = _pwd = value;
//		}
//		
//		override public function set text(value:String):void
//		{
//			if(_pwd)
//			{
//				var len:int = value.length;
//				var tmp:String = "";
//				while(len > 0)
//				{
//					tmp += "*";
//				}
//				_TextValue = value;
//				_TextField.text = tmp;
//			}
//		}
		
//		protected function Focus(event:FocusEvent):void
//		{
//		}
//		
//		protected function FocusLeave(event:FocusEvent):void
//		{
//		}
	}
}