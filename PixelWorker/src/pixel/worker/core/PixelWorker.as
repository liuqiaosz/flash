package pixel.worker.core
{
	import flash.system.MessageChannel;
	import flash.system.Worker;

	public class PixelWorker
	{
		private var _worker:Worker = null;
		private var _reciveChannel:MessageChannel = null;
		public function PixelWorker(worker:Worker)
		{
			_worker = worker;
			_reciveChannel = worker.getSharedProperty(PixelWorkerGeneric.CHANNEL_SENDER);
			if(_reciveChannel)
			{
				_reciveChannel.addEventListener(
			}
		}
	}
}