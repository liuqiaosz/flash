package
{
	import pixel.worker.core.PixelWorkerGeneric;
	
	public class TestWorker extends PixelWorkerGeneric
	{
		public function TestWorker(workerHandler:Class)
		{
			super(LogicHandler);
		}
	}
}

import flash.events.Event;
import flash.events.TimerEvent;
import flash.system.MessageChannel;
import flash.utils.Timer;

import pixel.worker.core.IPixelWorkerHandler;

class LogicHandler implements IPixelWorkerHandler
{
	private var _timer:Timer = null;
	private var _recive:MessageChannel = null;
	private var _sender:MessageChannel = null;
	public function LogicHandler()
	{
		_timer = new Timer(100);
		_timer.addEventListener(TimerEvent.TIMER,logic);
	}
	
	private var count:int = 0;
	private function logic(event:TimerEvent):void
	{
		_sender.send(count);
	}
	
	public function execute(recive:MessageChannel = null,sender:MessageChannel = null):void
	{
		_recive = recive;
		_sender = sender;
		
		_recive.addEventListener(Event.CHANNEL_MESSAGE,onRecive);
		_timer.start();
	}
	
	private function onRecive(event:Event):void
	{
		var value:int = _recive.receive() as int;
		trace(value + "");
	}
	
	public function terminal():void
	{
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER,logic);
		_timer = null;
	}
}