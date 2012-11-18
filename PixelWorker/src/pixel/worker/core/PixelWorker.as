package pixel.worker.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	
	import pixel.worker.event.PixelWorkerEvent;

	public class PixelWorker extends EventDispatcher
	{
		private var _worker:Worker = null;
		private var _reciveChannel:MessageChannel = null;
		private var _senderChannel:MessageChannel = null;
		public function PixelWorker(worker:Worker)
		{
			_worker = worker;
			_reciveChannel = worker.getSharedProperty(PixelWorkerGeneric.CHANNEL_SENDER);
			_senderChannel = worker.getSharedProperty(PixelWorkerGeneric.CHANNEL_RECIVE);
			if(_reciveChannel)
			{
				_reciveChannel.addEventListener(Event.CHANNEL_MESSAGE,onReciveMessage);
				
			}
		}
		
		protected function onReciveMessage(event:Event):void
		{
			var value:Object = _reciveChannel.receive();
			var notify:PixelWorkerEvent = new PixelWorkerEvent(PixelWorkerEvent.MESSAGE_AVAILABLE);
			notify.message = value;
			dispatchEvent(notify);
		}
		
		public function sendMessage(value:Object):void
		{
			if(_senderChannel)
			{
				_senderChannel.send(value);
			}
		}
		
		public function start():void
		{
			_worker.start();
		}
		
		public function stop():void
		{
			_worker.terminate();
		}
	}
}