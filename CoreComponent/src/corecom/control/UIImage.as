package corecom.control
{
	import corecom.control.style.ImageStyle;

	public class UIImage extends UIControl
	{
		public function UIImage(Skin:Class = null)
		{
			super((Skin == null ? ImageStyle:Skin));
		}
	}
}