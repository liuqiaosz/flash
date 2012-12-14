package editor.uitility.ui.event
{
	import flash.events.Event;

	public class PixelEditorEvent extends Event
	{
		public static const MENU_SELECTED:String = "MenuSelected";
		public static const PROMPT_ENTER:String = "PromptEnter";
		
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		public function PixelEditorEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}