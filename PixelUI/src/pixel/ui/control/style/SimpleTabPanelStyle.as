package pixel.ui.control.style
{
	public class SimpleTabPanelStyle extends ContainerStyle
	{
		public function SimpleTabPanelStyle()
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