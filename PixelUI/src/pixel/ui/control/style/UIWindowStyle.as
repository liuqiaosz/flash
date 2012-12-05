package pixel.ui.control.style
{
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.LayoutConstant;

	public class UIWindowStyle extends UIContainerStyle
	{
		public function UIWindowStyle()
		{
			super();
			BorderThinkness = 1;
			BorderColor = 0x666666;
			LeftBottomCorner = 4;
			RightBottomCorner = 4;
//			Width = 150;
//			Height = 100;
			Layout = LayoutConstant.VERTICAL;
			
			//BackgroundColor = 0xEEEEEE;
		}
	}
}