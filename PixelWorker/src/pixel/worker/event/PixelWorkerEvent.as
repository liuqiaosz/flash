package pixel.worker.event
{
	import flash.events.Event;

	public class PixelWorkerEvent extends Event
	{
		public static const MESSAGE_AVAILABLE:String = "MessageAvailable";
		public static const WORKER_COMPLETE:String = "WorkerComplete";
		
		private var _message:Object = null;
		public function set message(value:Object):void
		{
			_message = value;
		}
		public function get message():Object
		{
			return _message;
		}
		public function PixelWorkerEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}