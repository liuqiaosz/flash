package game.sdk.net
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import game.sdk.net.event.DownloadEvent;
	import game.sdk.net.event.NetProgressEvent;

	public class DownloadConnection extends EventDispatcher implements IDownloader
	{
		private var _Url:String = "";
		private var _UrlAddress:URLRequest = null;
		private var _Loader:Loader = null;
		private var _DownloadProcess:Boolean = false;
		public function DownloadConnection()
		{
			super();
			_Loader = new Loader();
			_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,DownloadComplete);
			_Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,DownloadProgress);
			_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,DonwloadError);
		}
		
		public function Connect(Url:String):void
		{
			_Url = Url;
			_UrlAddress = new URLRequest(_Url);
		}
		
		public function Request(Attr:IAttribute = null):void
		{
//			if(_Loader == null)
//			{
//				_Loader = new Loader();
//				_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,DownloadComplete);
//				_Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,DownloadProgress);
//				_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,DonwloadError);
//			}
			if(Attr)
			{
				_UrlAddress.data = Attr.GetPakcage();
			}
			_Loader.load(_UrlAddress);
			_DownloadProcess = true;
		}
		
		public function Download(Url:String):void
		{
			Connect(Url);
			Request();
		}
		
		private function DownloadComplete(event:Event):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_COMPLETE);
			Notify.Data = _Loader.content;
			dispatchEvent(Notify);
			_DownloadProcess = false;
		}
		
		private function DownloadProgress(event:ProgressEvent):void
		{
			var Notify:NetProgressEvent = new NetProgressEvent(DownloadEvent.DOWNLOAD_PROGRESS);
			Notify.Total = event.bytesTotal;
			Notify.Loaded = event.bytesLoaded;
			dispatchEvent(Notify);
		}
		
		private function DonwloadError(event:IOErrorEvent):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_ERROR);
			Notify.Data = event.text;
			dispatchEvent(Notify);
			_DownloadProcess = false;
		}
		
		public function Close():void
		{
			_Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,DownloadComplete);
			_Loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,DownloadProgress);
			_Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,DonwloadError);
			_Loader = null;
		}
	}
}