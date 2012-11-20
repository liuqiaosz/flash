package pixel.worker.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.registerClassAlias;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	
	import pixel.worker.event.PixelWorkerEvent;
	import pixel.worker.message.PixelWorkerMessageRequest;
	import pixel.worker.message.PixelWorkerMessageResponse;

	public class PixelWorker extends EventDispatcher
	{
		private var _worker:Worker = null;
		private var _reciveChannel:MessageChannel = null;
		private var _senderChannel:MessageChannel = null;
		public function PixelWorker(worker:Worker)
		{
			registerClassAlias("pixel.worker.message.PixelWorkerMessageRequest",PixelWorkerMessageRequest);
			registerClassAlias("pixel.worker.message.PixelWorkerMessageResponse",PixelWorkerMessageResponse);
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
		
		public function getShareProperty(name:String):Object
		{
			if(_worker)
			{
				return _worker.getSharedProperty(name);
			}
			return null;
		}
		public function setShareProperty(name:String,value:Object):void
		{
			if(_worker)
			{
				_worker.setSharedProperty(name,value);
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