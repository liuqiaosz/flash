package pixel.assets
{
	import pixel.assets.event.PixelAssetEvent;
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	/**
	 * 
	 * 默认下载器
	 * 
	 * 
	 * 
	 */
	public class PixelDefaultAssetLoader extends PixelAssetLoaderMarshal
	{
		protected var _run:Boolean = false;
		private var _loader:PixelAssetNode = null;
		public function PixelDefaultAssetLoader()
		{
		}

		override protected function haveTaskAdded():void
		{
			if(!_run)
			{
				loadTask();
			}
		}
		
		private var _currentTask:PixelAssetTask = null;
		private function loadTask():void
		{
			_run = true;
			_currentTask = getTask();
			if(_currentTask)
			{
				_loader = new PixelAssetNode(_currentTask.url);
				
				_loader.addEventListener(PixelAssetEvent.ASSET_COMPLETE,loadComplete);
				_loader.addEventListener(PixelAssetEvent.ASSET_PROGRESS,loadProgress);
				_loader.addEventListener(PixelAssetEvent.ASSET_ERROR,loadError);
			}
			else
			{
				_run = false;
			}
		}
		
		override public function stop():void
		{
			_run = false;
		}
		
		private function loadComplete(event:PixelAssetEvent):void
		{
			_currentTask.info = _loader;
			if(_currentTask.cache)
			{
				cacheAsset(_currentTask);
			}
			
			dispatchEvent(event);
			loadTask();
		}
		private function loadProgress(event:PixelAssetEvent):void
		{
			dispatchEvent(event);
		}
		private function loadError(event:PixelAssetEvent):void
		{
			dispatchEvent(event);
		}
	}
}