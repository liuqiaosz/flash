package corecom.control
{
	import corecom.control.style.UITextInputStyle;
	import corecom.core.LibraryInternal;
	
	import flash.events.FocusEvent;
	
	use namespace LibraryInternal;
	
	public class UITextInput extends UITextBase
	{
		public function UITextInput(Text:String = "",Skin:Class = null)
		{
			super(Skin?Skin:UITextInputStyle,Text);
			//允许文本输入
			this.Input = true;
			
		}
		
		override protected function RegisterEvent():void
		{
			super.RegisterEvent();
			addEventListener(FocusEvent.FOCUS_IN,Focus);
			addEventListener(FocusEvent.FOCUS_OUT,FocusLeave);
		}
		
		override protected function RemoveEvent():void
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