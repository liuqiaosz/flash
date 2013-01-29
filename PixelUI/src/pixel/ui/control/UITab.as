package pixel.ui.control
{
	import pixel.ui.core.PixelUINS;

	use namespace PixelUINS;
	
	public class UITab extends UIContainer
	{
		private var _bar:UITabBar = null;
		public function UITab()
		{
			this.Layout = LayoutConstant.VERTICAL;
			_bar = new UITabBar();
			addChild(_bar);
		}
		
		override final public function set Layout(Value:uint):void
		{
		}
	}
}