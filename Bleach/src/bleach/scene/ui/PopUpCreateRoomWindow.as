package bleach.scene.ui
{
	import bleach.event.BleachEvent;
	import bleach.event.BleachPopUpEvent;
	import bleach.utils.Constants;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIRadioGroup;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.vo.UIMod;
	
	public class PopUpCreateRoomWindow extends PopUpMask
	{
		private var _window:IUIContainer = null;
		private var _enter:UIButton = null;
		private var _cancel:UIButton = null;
		private var _close:UIButton = null;
		private var _name:UITextInput = null;
		private var _password:UITextInput = null;
		private var _radioGroup:UIRadioGroup = null;
		
		public function PopUpCreateRoomWindow()
		{
			super();
			var prototype:Object = getDefinitionByName("ui.createroom");
			if(prototype)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new prototype() as ByteArray);
				_window = mod.findControlById("1710032").control as IUIContainer;
				_window.x = (_screen.screenWidth - _window.width ) * .5;
				_window.y = (_screen.screenHeight - _window.height) * .5;
				addChild(_window as DisplayObject);
				
				_enter = _window.GetChildById("Enter",true) as UIButton;
				_cancel = _window.GetChildById("Cancel",true) as UIButton;
				_close = _window.GetChildById("Close",true) as UIButton;
				_name = _window.GetChildById("RoomName",true) as UITextInput;
				_password = _window.GetChildById("RoomPwd",true) as UITextInput;
				_radioGroup = _window.GetChildById("ModeGroup",true) as UIRadioGroup;
				_radioGroup.selectedIndex = 0;
				_enter.addEventListener(MouseEvent.CLICK,createEnter);
				_cancel.addEventListener(MouseEvent.CLICK,closeWindow);
				_close.addEventListener(MouseEvent.CLICK,closeWindow);
			}
		}
		
		public function get roomName():String
		{
			if(_name)
			{
				return _name.text;
			}
			return "";
		}
		public function get roomPwd():String
		{
			if(_password)
			{
				return _password.text;
			}
			return "";
		}
		
		public function get roomMode():int
		{
			if(_radioGroup)
			{
				switch(_radioGroup.selected.value)
				{
					case "1":
						return Constants.ROOM_CHALLENGE;
						break;
					case "2":
						return Constants.ROOM_ATHLETICS;
						break;
					default:
						return 0;
				}
			}
			return 0;
		}
		
		/**
		 * 确认创建
		 * 
		 **/
		private function createEnter(event:MouseEvent):void
		{
			dispatchEvent(new BleachPopUpEvent(BleachPopUpEvent.BLEACH_POP_ENTER));
		}
		
		private function closeWindow(event:MouseEvent):void
		{
			dispatchEvent(new BleachPopUpEvent(BleachPopUpEvent.BLEACH_POP_CLOSE));
		}
	}
}