package pixel.ui.control
{
	import pixel.ui.control.style.UITextInputStyle;
	import pixel.ui.core.NSPixelUI;
	
	import flash.events.FocusEvent;
	
	use namespace NSPixelUI;
	
	public class UITextInput extends UITextBase
	{
		public function UITextInput(Text:String = "",Skin:Class = null)
		{
			super(Skin?Skin:UITextInputStyle,Text);
			//允许文本输入
			this.Input = true;
			addEventListener(FocusEvent.FOCUS_IN,Focus);
			addEventListener(FocusEvent.FOCUS_OUT,FocusLeave);
			width = 100;
			height = 20;
		}
		
		override public function Dispose():void
		{
			removeEventListener(FocusEvent.FOCUS_IN,Focus);
			removeEventListener(FocusEvent.FOCUS_OUT,FocusLeave);
		}
		
		protected function Focus(event:FocusEvent):void
		{
		}
		
		protected function FocusLeave(event:FocusEvent):void
		{
		}
	}
}