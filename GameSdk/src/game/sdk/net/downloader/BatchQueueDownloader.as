package game.sdk.net.downloader
{
	import flash.events.EventDispatcher;
	
	import game.sdk.net.ConnectionManager;
	import game.sdk.net.DownloadConnection;
	import game.sdk.net.IConnection;
	import game.sdk.net.IDownloader;
	import game.sdk.net.IHTTPConnection;
	import game.sdk.net.event.BatchDownloadEvent;
	import game.sdk.net.event.DownloadEvent;
	import game.sdk.net.event.NetEvent;

	/**
	 * 批量SWF.图片下载
	 **/
	public class BatchQueueDownloader extends EventDispatcher implements IBatchDownloader
	{
		//当前下载队列下标
		private var _CurrentDownloadIndex:int = 0;
		
		private var _CurrentDownloadUrl:String = "";
		//当前下载的最大数据
		private var _CurrentDownloadTotalSize:int = 0;
		//当前已下载数据
		private var _CurrentDownloadedSize:int = 0;
		//当前下载队列
		private var _DownloadQueue:Vector.<String> = new Vector.<String>();
		//运转标识
		private var _DownloadProcess:Boolean = false;
		//下载连接
		private var _Connection:IDownloader = null;
		//队列每个文件下载所占百分比
		//private var _PercentOfSingle:int = 0;
		public function BatchQueueDownloader(LoaderFormat:uint = 0)
		{
			if(LoaderFormat == 0)
			{
				_Connection = ConnectionManager.GetDownloadConnecton();
			}
			else if(LoaderFormat == 1)
			{
				_Connection = ConnectionManager.GetBinaryDownloader();
			}
			_Connection.addEventListener(DownloadEvent.DOWNLOAD_COMPLETE,DownloadComplete);
			//_Connection.addEventListener(DownloadEvent.DOWNLOAD_PROGRESS,DownloadProgress);
			_Connection.addEventListener(DownloadEvent.DOWNLOAD_ERROR,DonwloadError);
		}
		
		/**
		 * 开始下载批次
		 **/
		public function StartBatchDownload(Queue:Vector.<String>):void
		{
			if(Queue && Queue.length > 0)
			{
				_DownloadQueue = _DownloadQueue.concat(Queue);
				//_DownloadQueue = Queue;
				_CurrentDownloadTotalSize = _DownloadQueue.length;
				Download();
			}
		}
		
		/**
		 * 
		 **/
		private function Download():void
		{
			if(_CurrentDownloadIndex >= _DownloadQueue.length)
			{
				//队列全部完成
				var Notify:BatchDownloadEvent = new BatchDownloadEvent(BatchDownloadEvent.DOWNLOAD_QUEUE_COMPLETE);
				dispatchEvent(Notify);
				_DownloadProcess = false;
				_CurrentDownloadIndex = 0;
				_CurrentDownloadTotalSize = 0;
			}
			else
			{
				_DownloadProcess = true;
				_CurrentDownloadUrl = _DownloadQueue[_CurrentDownloadIndex];
				_Connection.Download(_CurrentDownloadUrl);
			}
		}
		
		/**
		 * 队列单个下载完成
		 **/
		private function DownloadComplete(event:DownloadEvent):void
		{
			var Notify:BatchDownloadEvent = new BatchDownloadEvent(BatchDownloadEvent.DOWNLOAD_COMPLETE);
			Notify.CompleteContent = event.Data;
			Notify.DownloadIndex = _CurrentDownloadIndex;
			Notify.DownloadURL = _CurrentDownloadUrl;
			dispatchEvent(Notify);
			_CurrentDownloadIndex++;
			Download();
		}
//		private function DownloadProgress(event:DownloadEvent):void
//		{
//		}
		private function DonwloadError(event:DownloadEvent):void
		{
			var Notify:BatchDownloadEvent = new BatchDownloadEvent(BatchDownloadEvent.DOWNLOAD_ERROR);
			Notify.DownloadIndex = _CurrentDownloadIndex;
			Notify.DownloadURL = _CurrentDownloadUrl;
			dispatchEvent(Notify);
			_CurrentDownloadIndex++;
			Download();
		}
		
		public function PushToQueue(Url:String):void
		{
			if(_DownloadQueue.indexOf(Url) < 0)
			{
				_DownloadQueue.push(Url);
				if(!_DownloadProcess)
				{
					_CurrentDownloadTotalSize = _DownloadQueue.length;
					Download();
				}
			}
		}
	}
}