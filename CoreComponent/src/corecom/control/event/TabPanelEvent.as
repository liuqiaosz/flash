package corecom.control.event
{
	import corecom.control.Tab;
	
	import flash.events.Event;

	public class TabPanelEvent extends Event
	{
		public static const TABSELECT:String = "TabSelect";
		public static const TABACTIVE:String = "TabActive";
		
		private var _SelectTab:Tab = null;
		public function set SelectTab(Value:Tab):void
		{
			_SelectTab = Value;
		}
		public function get SelectTab():Tab
		{
			return _SelectTab;
		}
		
		public function TabPanelEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
	}
}