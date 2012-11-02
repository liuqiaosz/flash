package editor.ui
{
	import editor.event.NotifyEvent;
	
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	
	import spark.components.TitleWindow;

	public class AdvanceTitleWindow extends TitleWindow
	{
		public function AdvanceTitleWindow()
		{
			addEventListener(CloseEvent.CLOSE,OnCloseWindow);
		}
		
		private function OnCloseWindow(event:CloseEvent):void
		{
			removeEventListener(CloseEvent.CLOSE,OnCloseWindow);
			CloseWindow();
		}
		
		public function CloseWindow():void
		{
			var Notify:NotifyEvent = new NotifyEvent(NotifyEvent.WINDOW_CLOSE);
			dispatchEvent(Notify);
		}
		
		protected function Close(event:MouseEvent):void
		{
			CloseWindow();
		}
	}
}