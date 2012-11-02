package game.sdk.net
{
	import game.sdk.net.downloader.BatchQueueDownloader;
	import game.sdk.net.downloader.IBatchDownloader;

	public class ConnectionManager
	{
		public function ConnectionManager()
		{
		}
		
		public static function GetHttpConnection(Url:String = ""):IHTTPConnection
		{
			return new HTTPConnection(Url);	
		}
		
		public static function GetTcpConnection(Ip:String,Port:int):ITCPConnection
		{
			return null;
		}
		
		public static function GetDownloadConnecton():IDownloader
		{
			return new DownloadConnection();
		}
		
		public static function GetBatchDownloade():IBatchDownloader
		{
			return new BatchQueueDownloader();
		}
		
		public static function GetBinaryBatchDownloader():IBatchDownloader
		{
			return new BatchQueueDownloader(1);
		}
		
		public static function GetBinaryDownloader():IDownloader
		{
			return new BinaryDownLoader();
		}
	}
}