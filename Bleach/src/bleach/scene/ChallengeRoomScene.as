package bleach.scene
{
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class ChallengeRoomScene extends GenericScene
	{
		private var _window:IUIContainer = null;
		
		public function ChallengeRoomScene()
		{
			super();
		}
		
		override public function initializer():void
		{
			//ui.room.challenge
			var prototype:Object = getDefinitionByName("ui.room.challenge");
			if(prototype)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new prototype() as ByteArray);
				_window = mod.findControlById("ChallengeWindow").control as IUIContainer;
				_window.x = _window.y = 0;
				addChild(_window as DisplayObject);
			}
		}
	}
}