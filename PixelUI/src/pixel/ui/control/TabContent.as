package pixel.ui.control
{
	
	import pixel.ui.control.event.ControlEditModeEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class TabContent extends UIPanel
	{
		private var _OwnerTab:Tab = null;
		public function set OwnerTab(Value:Tab):void
		{
			_OwnerTab = Value;
		}
		public function get OwnerTab():Tab
		{
			return _OwnerTab;
		}
//		//标签内容面板所属的标签
//		private var _Owner:SimpleTabPanel = null;
//		public function set Owner(Value:SimpleTabPanel):void
//		{
//			_Owner = Value;
//		}
//		public function get Owner():SimpleTabPanel
//		{
//			return _Owner;
//		}
		public function TabContent(Skin:Class = null)
		{
			super(Skin);
		}
		

	}
}