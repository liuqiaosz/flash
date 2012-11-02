package corecom.control
{
	import corecom.control.style.UIProgressBarStyle;
	import corecom.core.LibraryInternal;

	use namespace LibraryInternal;
	
	internal class UIProgressBar extends UIControl
	{
		public function UIProgressBar(Style:Class = null)
		{
			super(Style?Style:UIProgressBarStyle);
		}
	}
}