package bleach.scene.ui
{
	import bleach.event.BleachEvent;
//	import bleach.event.BleachPopUpEvent;
	import bleach.utils.Constants;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;
	
	/**
	 * 地图选择弹出窗口
	 * 
	 **/
	public class PopUpSelectMap extends PopUpMask
	{
		private var _window:IUIContainer = null;
		public function PopUpSelectMap()
		{
			super();
			var prototype:Object = getDefinitionByName("ui.choosemap");
			if(prototype)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new prototype() as ByteArray);
				_window = mod.findControlById("MapPanel").control as IUIContainer;
				_window.x = (_screen.screenWidth - _window.width ) * .5;
				_window.y = (_screen.screenHeight - _window.height) * .5;
				addChild(_window as DisplayObject);
				
//				_enter = _window.GetChildById("Enter",true) as UIButton;
//				_cancel = _window.GetChildById("Cancel",true) as UIButton;
//				_close = _window.GetChildById("Close",true) as UIButton;
//				_name = _window.GetChildById("RoomName",true) as UITextInput;
//				_password = _window.GetChildById("RoomPwd",true) as UITextInput;
//				_radioGroup = _window.GetChildById("ModeGroup",true) as UIRadioGroup;
//				_enter.addEventListener(MouseEvent.CLICK,createEnter);
//				_cancel.addEventListener(MouseEvent.CLICK,closeWindow);
//				_close.addEventListener(MouseEvent.CLICK,closeWindow);
			}
		}
	}
}