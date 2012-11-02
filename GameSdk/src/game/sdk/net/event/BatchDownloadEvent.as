package game.sdk.net.event
{
	import flash.display.Bitmap;
	import flash.events.Event;

	public class BatchDownloadEvent extends Event
	{
		//全部完成
		public static const DOWNLOAD_COMPLETE:String = "DownloadComplete";
		
		public static const DOWNLOAD_STOP:String = "DownloadStop";
		
		//下载队列完成
		public static const DOWNLOAD_QUEUE_COMPLETE:String = "DownloadQueueComplete";
		//部分完成
		//public static const PART_COMPLETE:String = "PartComplete";
		//单个下载任务完成
		//public static const TASK_COMPLETE:String = "TaskComplete";
		
		//public static const DOWNLOAD_PROGRESS:String = "DownloadProgress";
		
		public static const DOWNLOAD_ERROR:String = "DownloadError";
		//完成的模块
		//public var CompleteModule:Module = null;
		//成功完成下载的队列
		public var CompleteQueue:Array = [];
		//下载过程中失败的队列
		public var FailureQueue:Array = [];
		//当前正在下载的模块
		//public var DownloadModule:Module = null;
		//当前模块需要下载的字节
		public var DownloadTotalSize:Number = 0;
		//当前模块已经下载的字节
		public var DownloadedSize:Number = 0;
		//当前下载模块所属队列的下标
		public var DownloadIndex:int = 0;
		//当前下载的URL
		public var DownloadURL:String = "";
		//完成的图片
		//public var CompleteImage:Bitmap = null;
		public var CompleteContent:Object = null;
		public function BatchDownloadEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}