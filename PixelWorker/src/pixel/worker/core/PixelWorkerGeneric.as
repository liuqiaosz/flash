package pixel.worker.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerState;

	public class PixelWorkerGeneric extends Sprite implements IPixelWorker
	{
		public static const CHANNEL_RECIVE:String = "ReciveChannel";
		public static const CHANNEL_SENDER:String = "SenderChannel";
		
		protected var _workerHandler:IPixelWorkerHandler = null;
		protected var _senderChannel:MessageChannel = null;
		protected var _reciveChannel:MessageChannel = null;
		public function PixelWorkerGeneric()
		{
			Worker.current.addEventListener(Event.WORKER_STATE,workerStateChanged);

		}
		
		protected function workerStateChanged(event:Event):void
		{
			switch(Worker.current.state)
			{
				case WorkerState.NEW:
					initializer();
					break;
				case WorkerState.RUNNING:
					start();
					break;
				case WorkerState.TERMINATED:
					terminal();
					break;
			}
		}
		
		/**
		 *
		 * 初始化操作
		 * 
		 * 当前线程状态为New时调用该方法进行运行前的初始化动作
		 * 
		 * 
		 */
		protected function initializer():void
		{
			_reciveChannel = getShareProperty(CHANNEL_RECIVE) as MessageChannel;
			_senderChannel = getShareProperty(CHANNEL_SENDER) as MessageChannel;
		}
		
		/**
		 * 
		 * 开始运作
		 * 
		 * 
		 */
		protected function start():void
		{
		}
		
		protected function terminal():void
		{
			if(_workerHandler)
			{
				//终止当前运行逻辑
				_workerHandler.terminal();
			}
		}
		
		/**
		 * 
		 * 
		 * 
		 */
		public function run(handler:Class):void
		{
			if(handler)
			{
				_workerHandler = new handler() as IPixelWorkerHandler;
				_workerHandler.execute(_reciveChannel,_senderChannel);
			}
		}
		
		protected function getShareProperty(propertyName:String):Object
		{
			return Worker.current.getSharedProperty(propertyName);
		}
		
		protected function setShareProperty(propertyName:String,property:Object):void
		{
			Worker.current.setSharedProperty(propertyName,property);
		}
	}
}