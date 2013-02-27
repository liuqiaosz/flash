package bleach.scene.ui
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;
	import pixel.core.PixelScreen;
	import pixel.utility.IDispose;
	import pixel.utility.IUpdate;

	public class PopUpLayer extends PixelNode implements IPopUp
	{
		//背景遮罩
		private var _mask:Shape = null;
		private var _screen:PixelScreen = null;
		private var _content:DisplayObject = null;
		public function PopUpLayer(content:DisplayObject,isCenter:Boolean = true,model:Boolean = true)
		{
			_content = content;
			_screen = PixelLauncher.launcher.screen;
			if(model)
			{
				_mask = new Shape();
				_mask.graphics.beginFill(0x000000,0.2);
				_mask.graphics.drawRect(0,0,_screen.screenWidth,_screen.screenHeight);
				_mask.graphics.endFill();
				addChild(_mask);
			}
			
			addChild(content);
			
			if(isCenter)
			{
				content.x = (_screen.screenWidth - content.width ) * .5;
				content.y = (_screen.screenHeight - content.height) * .5;
			}
		}
		
		public function get content():DisplayObject
		{
			return _content;
		}
		
		override public function update():void
		{
			IUpdate(_content).update();
		}
		
		override public function dispose():void
		{
			super.dispose();
			IDispose(_content).dispose();
		}
	}
}