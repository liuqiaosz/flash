package bleach.scene.ui
{
	import bleach.BleachDirector;
	import bleach.SceneModule;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;

	/**
	 * 弹出
	 * 
	 * 
	 **/
	public class PopUpWindow extends PixelNode
	{
		public function PopUpWindow(model:Boolean = false,module:SceneModule)
		{
			super();
			if(model)
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000,0.7);
				//this.graphics.drawRect(0,0,PixelLauncher.launcher.screen.screenWidth,
			}
		}
	}
}