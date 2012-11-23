package pixel.ui.control
{
	import pixel.ui.control.style.UIProgressBarStyle;
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI;
	
	internal class UIProgressBar extends UIControl
	{
		public function UIProgressBar(Style:Class = null)
		{
			super(Style?Style:UIProgressBarStyle);
		}
	}
}