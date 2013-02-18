package bleach.event
{
	import flash.events.Event;

	public class BleachPopUpEvent extends Event
	{
		public static const BLEACH_POP_CLOSE:String = "PopUpClose";
		public static const BLEACH_POP_ENTER:String = "PopUpEnter";
		
		public function BleachPopUpEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}