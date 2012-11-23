package pixel.ui.control.style
{
	/**
	 * 滚动条样式
	 * 
	 */
	public class UIScrollerStyle extends UIStyle
	{
		private var _handlerStyle:IVisualStyle = null;
		public function UIScrollerStyle()
		{
			_handlerStyle = new UIStyle();
		}
		
		public function get handlerStyle():IVisualStyle
		{
			return _handlerStyle;
		}
	}
}