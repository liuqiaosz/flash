package
{
	import bleach.scene.GenericScene;
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class AthleticsScene extends GenericScene
	{
		private var _window:IUIContainer = null;
		
		public function AthleticsScene()
		{
			super();
			var prototype:Object = getDefinitionByName("ui.room.athletics");
			if(prototype)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new prototype() as ByteArray);
				_window = mod.findControlById("AthleticsWindow").control as IUIContainer;
				
				_window.x = _window.y = 0;
				addChild(_window as DisplayObject);
			}
		}
	}
}