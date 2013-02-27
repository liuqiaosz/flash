package bleach.scene.ui
{
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;
	import pixel.core.PixelScreen;
	import pixel.message.PixelMessage;
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIImage;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.vo.UIControlMod;
	import pixel.ui.control.vo.UIMod;
	
	public class DialogWindow extends PopUpMask
	{
		private var _window:IUIContainer = null;
		private var _text:UILabel = null;
		public function DialogWindow()
		{
			super();
			var preloadData:Object = getDefinitionByName("ui.common");
			if(preloadData)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new preloadData() as ByteArray) as UIMod;
				var controlMod:UIControlMod = mod.findControlById("DialogWindow");
				if(controlMod)
				{
					_window = controlMod.control as UIContainer;
					_text = _window.GetChildById("DialogText",true) as UILabel;
					
					addChild(_window as DisplayObject);
					_window.x = (_screen.screenWidth - _window.width ) * .5;
					_window.y = (_screen.screenHeight - _window.height) * .5;
				}
			}
		}
		
		public function set text(value:String):void
		{
			_text.text = value;
		}
	}
}