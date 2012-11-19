package pixel.ui.control
{
	import pixel.ui.control.style.UIProgressBarStyle;
	import pixel.ui.core.LibraryInternal;

	use namespace LibraryInternal;
	
	internal class UIProgressBar extends UIControl
	{
		public function UIProgressBar(Style:Class = null)
		{
			super(Style?Style:UIProgressBarStyle);
		}
	}
}