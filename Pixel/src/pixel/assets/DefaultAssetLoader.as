package pixel.assets
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	/**
	 * 
	 * 默认下载器
	 * 
	 * 
	 * 
	 */
	public class DefaultAssetLoader extends EventDispatcher implements IAssetsLoader
	{
		protected var _taskQueue:Vector.<AssetTask> = null;
		protected var _run:Boolean = false;
		private var _loader:Loader = null;
		public function DefaultAssetLoader()
		{
			_taskQueue = new Vector.<String>();
			
		}
		
		/**
		 * 
		 * 
		 * 添加任务到当前下载队列
		 * 
		 * 
		 */
		public function pushTaskToQueue(task:AssetTask):void
		{
			_taskQueue.push(task);
			haveNewTask();
		}
		
		protected function haveNewTask():void
		{
			if(!_run)
			{
				
			}
		}
		
		private var _currentTask:AssetTask = null;
		private function loadTask():void
		{
			if(_taskQueue.length > 0)
			{
				_run = true;
				_currentTask = _taskQueue.shift();
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
				
			}
			
		}
		
		private function loadComplete(event:Event):void
		{
			_currentTask.info = _loader;
			_assetCache[_currentTask.alias] = _currentTask;
			_assetArray.push(_currentTask);
			
			if(_taskQueue.length > 0)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				loadTask();
			}
			else
			{
				_run = false;
			}
		}
		
		protected var _assetCache:Dictionary = new Dictionary();
		protected var _assetArray:Vector.<Loader> = new Vector.<Loader>();
		
		/**
		 * 通过别名获取下载资源库
		 */
		public function findAssetsByAlias(alias:String):Loader
		{
			if(alias in _assetCache)
			{
				return _assetCache[alias];
			}
			return null;
		}
	}
}