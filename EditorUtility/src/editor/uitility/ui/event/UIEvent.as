package editor.uitility.ui.event
{
	import flash.events.Event;

	public class UIEvent extends Event
	{
		public static const WINDOW_CLOSE:String = "WindowClose";
		public static const WINDOW_ENTER:String = "WindowEnter";
		public static const FRAME_RESIZED:String = "FrameResized";
		public var Params:Array = [];
		public function UIEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}