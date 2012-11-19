package pixel.ui.control.style
{
	public class TabPanelStyle extends ContainerStyle
	{
		public function TabPanelStyle()
		{
			super();
			BorderThinkness = 0;
		}
		
		private var _TabHeight:int = 0;
		public function set TabHeight(Value:int):void
		{
			_TabHeight = Value;
		}
		public function get TabHeight():int
		{
			return _TabHeight;
		}
	}
}