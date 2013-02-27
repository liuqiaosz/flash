package bleach.scene.ui
{
	
	import bleach.scene.GenericScene;
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class PopUpBagWindow extends PopUpMask
	{
		private var _window:IUIContainer = null;
		
		public function PopUpBagWindow()
		{
			super();
			var prototype:Object = getDefinitionByName("ui.role");
			if(prototype)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new prototype() as ByteArray);
				_window = mod.findControlById("Role032").control as IUIContainer;
				
				_window.x = (_screen.screenWidth - _window.width ) * .5;
				_window.y = (_screen.screenHeight - _window.height) * .5;
				addChild(_window as DisplayObject);
			}
			
		}
	}
}