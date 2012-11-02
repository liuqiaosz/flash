package editor.ui
{
	import flash.net.dns.AAAARecord;

	public class NotificationManager
	{
		private static var _Instance:INotification = null;
		public function NotificationManager()
		{
		}
		
		public static function get Instance():INotification
		{
			if(null == _Instance)
			{
				_Instance = new NitificationImpl();
			}
			return _Instance;
		}
	}
}
import editor.ui.INotification;
import editor.ui.NotificationPanel;

import flash.display.DisplayObject;

import mx.core.FlexGlobals;
import mx.managers.PopUpManager;

/**
 * 屏幕通知实现
 **/
class NitificationImpl implements INotification
{
	private var Notify:NotificationPanel = null;
	public function NitificationImpl()
	{
		Notify = new NotificationPanel();
	}
	
	public function Show(Message:String,Duration:Number = 1500):void
	{
		Notify.Message = Message;
		PopUpManager.addPopUp(Notify,FlexGlobals.topLevelApplication as DisplayObject,false);
		PopUpManager.centerPopUp(Notify);
		Notify.y = 20;
		Notify.PlayFadeEffect(Duration);
	}
	public function Hide():void
	{
		PopUpManager.removePopUp(Notify);
	}
}