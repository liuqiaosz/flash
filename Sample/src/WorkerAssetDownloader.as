package
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import pixel.assets.PixelAssetLoaderMarshal;
	import pixel.assets.PixelAssetTask;
	import pixel.worker.core.PixelWorker;
	import pixel.worker.core.PixelWorkerHelper;
	import pixel.worker.core.ShareMemory;
	import pixel.worker.event.PixelWorkerEvent;
	import pixel.worker.message.PixelWorkerLoaderMessageResponse;
	import pixel.worker.message.PixelWorkerMessage;
	import pixel.worker.message.PixelWorkerMessageRequest;

	public class WorkerAssetDownloader extends PixelAssetLoaderMarshal
	{
		[Embed(source="../bin-debug/TestWorker.swf",mimeType="application/octet-stream")]
		private var workerClass:Class;
		
		private var _worker:PixelWorker = null;
		protected var _initialized:Boolean = false;
		protected var _haveWait:Boolean = false;
		public function WorkerAssetDownloader()
		{
			super();
			initializer();
			registerClassAlias("pixel.worker.message.PixelWorkerLoaderMessageResponse",PixelWorkerLoaderMessageResponse);
		}
		
		protected function initializer():void
		{
			_worker = PixelWorkerHelper.instance.createWorkerByByteArray(new workerClass() as ByteArray);
			_worker.start();
			_worker.addEventListener(PixelWorkerEvent.MESSAGE_AVAILABLE,onMessageAvailable);
			_initialized = true;
			if(_haveWait)
			{
				haveTaskAdded();
			}
		}
		
		private var _currentTask:PixelAssetTask = null;
		override protected function haveTaskAdded():void
		{
			if(_initialized)
			{
				var request:PixelWorkerMessageRequest = new PixelWorkerMessageRequest(PixelWorkerMessage.LOAD_SWF);
				_currentTask = getTask();
				request.message = _currentTask.url;
				_worker.sendMessage(request);
			}
			else
			{
				_haveWait = true;
			}
			
		}
		
		private function onMessageAvailable(event:PixelWorkerEvent):void
		{
			var msg:PixelWorkerLoaderMessageResponse = event.message as PixelWorkerLoaderMessageResponse;
			
			switch(msg.type)
			{
				case PixelWorkerMessage.LOAD_COMPLETE:
					break;
				case PixelWorkerMessage.LOAD_PROGRESS:
					break;
				case PixelWorkerMessage.LOAD_ERROR:
					break;
			}
			if(msg.shareMemory)
			{
				var memory:ByteArray = _worker.getShareProperty(ShareMemory.SHARE_BYTEARRAY) as ByteArray;
				var a:flash.display.Loader = new flash.display.Loader();
				var ctx:LoaderContext = new LoaderContext();
				ctx.applicationDomain = ApplicationDomain.currentDomain;
				ctx.allowCodeImport = true;
				a.loadBytes(memory,ctx);
				a.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
					
					memory.clear();
					var vec:Vector.<String> = a.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
					trace(vec.length + "]");
				});
			}
		}
		
	}
}