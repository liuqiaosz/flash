package pixel.ui.control.style
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import pixel.ui.control.event.PixelUIEvent;

	public class UIGlobalStyleManager
	{
		private static var _instance:UIGlobalStyleManager = new UIGlobalStyleManager();
		
		private var _loader:URLLoader = null;
		//等待下载任务队列
		private var _waitQueue:Vector.<String> = new Vector.<String>();
		//当前下载的URL
		private var _currentTask:String = "";
		//当前下载状态
		private var _loading:Boolean = false;
		
		private var _cache:Dictionary = new Dictionary();
		
		public function UIGlobalStyleManager()
		{
			if(_instance)
			{
				throw new Error("Singlton");
			}
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE,downloadComplete);
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		public static function get instance():UIGlobalStyleManager
		{
			return _instance;
		}
		
		/**
		 * 将一个下载URL连接加入下载队列
		 * 
		 **/
		public function download(url:String):void
		{
			_waitQueue.push(url);
			if(!_loading)
			{
				//当前没有启动下载
				startDownload();
			}
		}
		
		private function startDownload():void
		{
			if(_waitQueue.length > 0)
			{
				_currentTask = _waitQueue.shift();
				_loader.load(new URLRequest(_currentTask));
			}
		}
		
		private function downloadComplete(event:Event):void
		{
			var idx:int = 0;
			var source:ByteArray = _loader.data as ByteArray;
			var idCount:int = source.readByte();
			for(idx; idx<idCount; idx++)
			{
				
			}
			//var notify:PixelUIEvent = new PixelUIEvent(PixelUIEvent.STYLE_DONWLOAD_COMPLETE);
			
		}
	}
}