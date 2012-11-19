package pixel.assets
{
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	
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
		
		private function loadTask():void
		{
			
		}
	}
}