package pixel.ui.control.event
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ScrollerEvent extends Event
	{
		public static const SCROLL_UPDATE:String = "ScrollUpdate";
		
		public var ScrollRect:Rectangle = new Rectangle();
		
		public function ScrollerEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
	}
}