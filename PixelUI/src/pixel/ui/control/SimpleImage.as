package pixel.ui.control
{
	import pixel.ui.control.style.ImageStyle;

	public class SimpleImage extends UIControl
	{
		public function SimpleImage(Skin:Class = null)
		{
			super((Skin == null ? ImageStyle:Skin));
		}
	}
}