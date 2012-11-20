package pixel.worker.handler
{
	import flash.utils.ByteArray;
	
	import pixel.worker.core.ShareMemory;
	import pixel.worker.message.PixelWorkerLoaderMessageResponse;
	import pixel.worker.message.PixelWorkerMessage;
	import pixel.worker.message.PixelWorkerMessageRequest;
	
	import utility.loader.Loader;

	/**
	 * 
	 * 数据加载逻辑处理模版
	 * 
	 * 
	 */
	public class PixelLoaderWorkerHandler extends PixelWorkerHandler
	{
		private var _taskQueue:Vector.<String> = null;
		private var _run:Boolean = false;
		public function PixelLoaderWorkerHandler()
		{
			_taskQueue = new Vector.<String>();
			registerClassAlias("pixel.worker.message.PixelWorkerLoaderMessageResponse",PixelWorkerLoaderMessageResponse);
		}
		
		/**
		 * 
		 * 获取消息
		 * 
		 * 该逻辑处理只接收URL下载消息，message为要下载资源的远程URL
		 * 
		 */
		override protected function onReciveMessage(message:Object):void
		{
			if(message is PixelWorkerMessageRequest)
			{
				_taskQueue.push(PixelWorkerMessageRequest(message).message);
				if(!_run)
				{
					startLoad();
				}
			}
		}
		
		private var _loader:Loader = null;
		private var _currentURL:String = "";
		private function startLoad():void
		{
			if(_taskQueue.length > 0)
			{
				_currentURL = _taskQueue.pop();
				_loader = new Loader(_currentURL,loadComplete,loadProgress,loadError);
				_loader.download();
			}
			else
			{
				var msg:PixelWorkerLoaderMessageResponse = new PixelWorkerLoaderMessageResponse(PixelWorkerMessage.LOAD_COMPLETE_ALL);
				sendMessage(msg);
			}
		}
		import flash.net.registerClassAlias;
		private function loadComplete():void
		{
			var data:ByteArray = _loader.data as ByteArray;
			
			var msg:PixelWorkerLoaderMessageResponse = new PixelWorkerLoaderMessageResponse(PixelWorkerMessage.LOAD_COMPLETE);
			ShareMemory.setByteArrayMemory(data);
			msg.shareMemory = true;
			msg.url = _currentURL;
			sendMessage(msg);
			_loader.close();
		}
		
		private function loadProgress(total:int,loaded:int):void
		{
			//sendMessage("Total[" + total + "] Loaded[" + loaded + "]");
		}
		
		private function loadError(message:String):void
		{}
	}
}