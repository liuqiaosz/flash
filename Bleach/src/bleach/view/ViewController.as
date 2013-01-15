package bleach.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import pixel.core.IPixelSprite;
	import pixel.core.PixelLayer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class ViewController extends PixelLayer implements IViewController
	{
		public function ViewController()
		{
			this.mouseEnabled = false;
		}
		
		public function initWithData(data:Object):void
		{
		}
		
		
	}
}