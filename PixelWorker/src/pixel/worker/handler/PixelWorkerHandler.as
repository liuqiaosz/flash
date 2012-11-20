package pixel.worker.handler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.registerClassAlias;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	
	import pixel.worker.core.IPixelWorkerHandler;
	import pixel.worker.message.PixelWorkerMessageRequest;
	import pixel.worker.message.PixelWorkerMessageResponse;

	public class PixelWorkerHandler extends EventDispatcher implements IPixelWorkerHandler
	{
		private var _recive:MessageChannel = null;
		public function get recive():MessageChannel
		{
			return _recive;
		}
		private var _sender:MessageChannel = null;
		public function get sender():MessageChannel
		{
			return _sender;
		}
		
		public function PixelWorkerHandler()
		{
			registerClassAlias("pixel.worker.message.PixelWorkerMessageRequest",PixelWorkerMessageRequest);
			registerClassAlias("pixel.worker.message.PixelWorkerMessageResponse",PixelWorkerMessageResponse);
		}
		
		public function execute(recive:MessageChannel = null,sender:MessageChannel = null):void
		{
			_recive = recive;
			_sender = sender;
			
			_recive.addEventListener(Event.CHANNEL_MESSAGE,onRecive);
			
			
		}
		
		private function onRecive(event:Event):void
		{
			var message:Object = _recive.receive();
			onReciveMessage(message);
		}
		
		protected function onReciveMessage(message:Object):void
		{
			
		}
		
		public function sendMessage(value:Object):void
		{
			if(_sender)
			{
				_sender.send(value);
			}
		}
		
		public function terminal():void
		{
			_recive.removeEventListener(Event.CHANNEL_MESSAGE,onRecive);
		}
		
		protected function getShareProperty(propertyName:String):Object
		{
			return Worker.current.getSharedProperty(propertyName);
		}
		
		
	}
}