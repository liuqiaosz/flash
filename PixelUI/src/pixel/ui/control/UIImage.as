package pixel.ui.control
{
	import pixel.ui.control.style.ImageStyle;

	public class UIImage extends UIControl
	{
		public function UIImage(Skin:Class = null)
		{
			super((Skin == null ? ImageStyle:Skin));
		}
	}
}