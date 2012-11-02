package corecom.control.event
{
	import flash.events.Event;

	public class ControlEditModeEvent extends Event
	{
		public static var CHILDSELECTED:String = "ChildSelected";
		public var Params:Array = [];
		public var Message:String = "";
		public function ControlEditModeEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}