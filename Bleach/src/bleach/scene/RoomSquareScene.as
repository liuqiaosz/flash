package bleach.scene
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;
	
	public class RoomSquareScene extends GenericScene
	{
		
		
		public function RoomSquareScene()
		{
			super();
		}
		
		private var _room:UIControl = null;
		override public function initializer():void
		{
			var uiDefine:Object = getDefinitionByName("ui.roomsquare");
			if(uiDefine)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new uiDefine() as ByteArray);
				_room = mod.controls.pop().control;
				_room.x = _room.y = 0;
				addChild(_room);
			}
		}
	}
}