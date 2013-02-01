package pixel.ui.control.event
{
	import pixel.ui.control.asset.IAssetLibrary;

	public class DownloadEvent extends UIControlEvent
	{
		public static const DOWNLOAD_START:String = "DownloadStart";
		public static const DOWNLOAD_PROGRESS:String = "DownloadPogress";
		public static const DOWNLOAD_ERROR:String = "DownloadError";
		public static const DOWNLOAD_SUCCESS:String = "DownloadSuccess";
		public static const DOWNLOAD_SINGLETASK_SUCCESS:String = "DownloadSingleTaskSuccess";
		
		//加载文件总数
		private var _Total:int = 0;
		public function set Total(Value:int):void
		{
			_Total = Value;
		}
		public function get Total():int
		{
			return _Total;
		}
		//当前加载的文件
		private var _CurrentIndex:int = 0;
		public function set CurrentIndex(Value:int):void
		{
			_CurrentIndex = Value;
		}
		public function get CurrentIndex():int
		{
			return _CurrentIndex;
		}
		//当前加载文件的URL
		private var _CurrentUri:String = "";
		public function set CurrentUri(Value:String):void
		{
			_CurrentUri = Value;
		}
		public function get CurrentUri():String
		{
			return _CurrentUri;
		}
		//当前文件的数据大小
		private var _TotalBytes:int = 0;
		public function set TotalBytes(Value:int):void
		{
			_TotalBytes = Value;
		}
		public function get TotalBytes():int
		{
			return _TotalBytes;
		}
		//已加载的数据
		private var _LoadedBytes:int = 0;
		public function set LoadedBytes(Value:int):void
		{
			_LoadedBytes = Value;
		}
		public function get LoadedBytes():int
		{
			return _LoadedBytes;
		}
		
//		private var _CurrentSwf:Swf = null;
//		public function set CurrentSwf(Value:Swf):void
//		{
//			_CurrentSwf = Value;
//		}
//		public function get CurrentSwf():Swf
//		{
//			return _CurrentSwf;
//		}
		private var _currentLibrary:IAssetLibrary = null;
		public function set library(value:IAssetLibrary):void
		{
			_currentLibrary = value;
		}
		public function get library():IAssetLibrary
		{
			return _currentLibrary;
		}
		public function DownloadEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
	}
}