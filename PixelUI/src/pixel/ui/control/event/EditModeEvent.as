package pixel.ui.control.event
{
	import flash.events.Event;

	public class EditModeEvent extends Event
	{
		public static const FRAME_FOCUS:String = "FrameFocus";
		public static const FRAME_UNFOCUS:String = "FrameUnFocus";
		public static const FRAME_RESIZED:String = "FrameResized";
		public static const CONTROL_MOVED:String = "ControlMoved";
		
		public function EditModeEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}