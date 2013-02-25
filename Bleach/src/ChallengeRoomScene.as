package 
{
	import bleach.event.BleachPopUpEvent;
	import bleach.message.BleachPopUpMessage;
	import bleach.scene.ui.PopUpSelectMap;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;
	import bleach.scene.GenericScene;

	public class ChallengeRoomScene extends GenericScene
	{
		private var _window:IUIContainer = null;
		private var _selectMap:UIButton = null;
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
				_selectMap = _window.GetChildById("challenge012",true) as UIButton; 
				_window.x = _window.y = 0;
				addChild(_window as DisplayObject);
				_selectMap.addEventListener(MouseEvent.CLICK,openMapSelectWindlw);
			}
		}
		private var _selectWidnow:PopUpSelectMap = null;
		private function openMapSelectWindlw(event:MouseEvent):void
		{
			var msg:BleachPopUpMessage = new BleachPopUpMessage(BleachPopUpMessage.BLEACH_POPUP_SHOW);
			_selectWidnow = new PopUpSelectMap();
			msg.value = _selectWidnow;
			dispatchMessage(msg);

			_selectWidnow.addEventListener(BleachPopUpEvent.BLEACH_POP_CLOSE,function(e:BleachPopUpEvent):void{
				trace("close");
			});
			
			//_selectMap.addEventListener(BleachPopUpEvent.BLEACH_POP_ENTER,onCreateRoomEnter);
		}
	}
}