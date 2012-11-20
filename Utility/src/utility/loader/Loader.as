package utility.loader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class Loader extends URLLoader
	{
		private var _url:String = "";
		private var _complete:Function = null;
		private var _progress:Function = null;
		private var _error:Function = null;
		public function Loader(url:String = "",complete:Function = null,progress:Function = null,error:Function = null)
		{
			super();

			addEventListener(Event.COMPLETE,onComplete);
			addEventListener(ProgressEvent.PROGRESS,onProgress);
			addEventListener(IOErrorEvent.IO_ERROR,onError);
			_complete = complete;
			_progress = progress;
			_error = error;
			_url = url;
			super.dataFormat = URLLoaderDataFormat.BINARY; 
		}
		
		public function download(url:String = null):void
		{
			if(url != null)
			{
				_url = url;
			}
			
			super.load(new URLRequest(_url));
		}

		private function onComplete(event:Event):void
		{
			if(_complete != null)
			{
				_complete();
			}
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			if(null != _progress)
			{
				_progress(event.bytesTotal,event.bytesLoaded);
			}
		}
		private function onError(event:IOErrorEvent):void
		{
			if(null != _error)
			{ 
				_error(event.text);
			}
		}
		
		
		public function dispose():void
		{
			removeEventListener(Event.COMPLETE,onComplete);
			removeEventListener(ProgressEvent.PROGRESS,onProgress);
			removeEventListener(IOErrorEvent.IO_ERROR,onError);
		}
	}
}