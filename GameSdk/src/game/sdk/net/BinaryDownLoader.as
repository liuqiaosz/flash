package game.sdk.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import game.sdk.net.event.DownloadEvent;
	import game.sdk.net.event.NetProgressEvent;

	/**
	 * 二进制下载器
	 **/
	public class BinaryDownLoader extends HTTPConnection  implements IDownloader
	{
		private var _Url:String = "";
		public function BinaryDownLoader()
		{
			super();
			super.Format = URLLoaderDataFormat.BINARY;
		}
		
		public function Download(Url:String):void
		{
			Connect(Url);
			Request();
		}
		
		override public function set Format(Value:String):void
		{
		}
		
		/**
		 * IO异常
		 **/
		override protected function OnIoError(event:IOErrorEvent):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_ERROR);
			Notify.Data = event.text;
			dispatchEvent(Notify);
			this._Process = false;
		}
		
		/**
		 * 安全异常
		 **/
		override protected function OnSecurityError(event:SecurityErrorEvent):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_ERROR);
			Notify.Data = event.text;
			dispatchEvent(Notify);
			this._Process = false;
		}
		
		/**
		 * 加载中
		 **/
		override protected function OnProgress(event:ProgressEvent):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_PROGRESS);
			Notify.DownloadTotalSize = event.bytesTotal;
			Notify.DownloadedSize = event.bytesLoaded;
			dispatchEvent(Notify);
		}
		
		/**
		 * 成功
		 **/
		override protected function OnComplete(event:Event):void
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_COMPLETE);
			Notify.Data = _Loader.data as ByteArray;
			dispatchEvent(Notify);
			_Process = false;
		}
	}
}