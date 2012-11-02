package game.sdk.net.event
{
	import flash.events.Event;

	public class DownloadEvent extends Event
	{
		public static const DOWNLOAD_COMPLETE:String = "DownloadComplete";
		public static const DOWNLOAD_PROGRESS:String = "DownloadProgress";
		public static const DOWNLOAD_ERROR:String = "DownloadError";
		
		public var Data:Object = null;
		
		//当前模块需要下载的字节
		public var DownloadTotalSize:Number = 0;
		//当前模块已经下载的字节
		public var DownloadedSize:Number = 0;
		//下载所占百分比
		public var DownloadPercent:int = 0;
		
		public function DownloadEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}