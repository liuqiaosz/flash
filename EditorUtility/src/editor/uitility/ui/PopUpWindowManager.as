package editor.uitility.ui
{
	import editor.uitility.ui.event.UIEvent;
	
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;

	public class PopUpWindowManager
	{
		//private static var _CurrentShow:IFlexDisplayObject = null;
		
		private static var _WindowStack:Vector.<IFlexDisplayObject> = new Vector.<IFlexDisplayObject>();
		public function PopUpWindowManager()
		{
		}
		
		public static function PopUp(WindowClass:Class,Center:Boolean = true,Model:Boolean = true):IFlexDisplayObject
		{
//			if(null != _CurrentShow)
//			{
//				_CurrentShow.removeEventListener(UIEvent.WINDOW_CLOSE,WindowClose);
//				PopUpManager.removePopUp(_CurrentShow);
//				_CurrentShow = null;
//			}
			var Window:IFlexDisplayObject = new WindowClass() as IFlexDisplayObject;
			Window.addEventListener(UIEvent.WINDOW_CLOSE,WindowClose);
			_WindowStack.push(Window);
			PopUpManager.addPopUp(Window,FlexGlobals.topLevelApplication as DisplayObject,Model);
			if(Center)
			{
				PopUpManager.centerPopUp(Window);
			}
			
			return Window;
		}
		
		private static function WindowClose(event:UIEvent):void
		{
			var Window:IFlexDisplayObject = event.currentTarget as IFlexDisplayObject;
			if(Window)
			{
				Window.removeEventListener(UIEvent.WINDOW_CLOSE,WindowClose);
				PopUpManager.removePopUp(Window);
				
				if(_WindowStack.indexOf(Window) >= 0)
				{
					_WindowStack.splice(_WindowStack.indexOf(Window),1);
				}
				//_CurrentShow = null;
			}
		}
	}
}