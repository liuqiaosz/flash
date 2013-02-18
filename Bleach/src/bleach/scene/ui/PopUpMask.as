package bleach.scene.ui
{
	import flash.display.Shape;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;
	import pixel.core.PixelScreen;
	
	public class PopUpMask  extends PixelNode
	{
		protected var _mask:Shape = null;
		protected var _screen:PixelScreen = null;
		
		public function PopUpMask()
		{
			super();
			_screen = PixelLauncher.launcher.screen;
			_mask = new Shape();
			_mask.graphics.beginFill(0x000000,0.7);
			_mask.graphics.drawRect(0,0,_screen.screenWidth,_screen.screenHeight);
			_mask.graphics.endFill();
			addChild(_mask);
		}
	}
}