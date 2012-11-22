package pixel.utility.swf.event
{
	import flash.events.Event;

	public class SWFEvent extends Event
	{
		public static const ASYNCLOAD_COMPLETE:String = "AsyncLoadComplete";
		
		public function SWFEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}