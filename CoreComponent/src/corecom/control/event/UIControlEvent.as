package corecom.control.event
{
	import flash.events.Event;

	public class UIControlEvent extends Event
	{
		public static const RENDER_UPDATE:String = "RenderUpdate";
		public static const STYLE_UPDATE:String = "StyleUpdate";
		
		public static const BUTTON_DOWN:String = "ButtonDown";
		public static const BUTTON_UP:String = "ButtonUp";
		
		public static const TEXTFILED_VALUE_CHANGED:String = "TextFieldValueChanged";
		
		public function UIControlEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
	}
}