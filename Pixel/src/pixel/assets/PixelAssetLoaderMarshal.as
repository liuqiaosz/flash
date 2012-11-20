package pixel.assets
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	/**
	 * 
	 * 抽象类
	 * 
	 * 所有资源加载器都要继承该类进行扩展
	 * 该类主要进行资源的管理
	 * 
	 */
	public class PixelAssetLoaderMarshal extends EventDispatcher implements IPixelAssetsMarshal
	{
		//当前等待的任务队列
		protected var _waitTaskQueue:Vector.<PixelAssetTask> = null;
		//已完成资源的缓存
		protected var _assetCache:Dictionary = new Dictionary();
		protected var _assetArray:Vector.<PixelAssetTask> = new Vector.<PixelAssetTask>();
		
		public function PixelAssetLoaderMarshal()
		{
			_waitTaskQueue = new Vector.<PixelAssetTask>();
			_assetCache = new Dictionary();
			_assetArray = new Vector.<PixelAssetTask>();
		}
		
		public function pushTaskToQueue(task:PixelAssetTask):void
		{
			_waitTaskQueue.push(task);
			haveTaskAdded();
		}
		
		protected function haveTaskAdded():void
		{
			
		}
		
		public function stop():void
		{}
		public function getQueue():Vector.<PixelAssetTask>
		{
			return _waitTaskQueue;
		}
		
		public function getCacheArray():Vector.<PixelAssetTask>
		{
			return _assetArray;
		}
		
		/**
		 * 
		 * 合并缓存
		 */
		public function margeCache(cache:Vector.<PixelAssetTask>):void
		{
			_assetArray = _assetArray.concat(cache);
		}
		
		
		protected function getTask():PixelAssetTask
		{
			if(_waitTaskQueue.length > 0)
			{
				return _waitTaskQueue.shift();
			}
			return null;
		}
		
		protected function cacheAsset(task:PixelAssetTask):void
		{
			_assetCache[task.alias] = task;
			_assetArray.push(task);
		}
		
		public function findAssetsByAlias(alias:String):PixelAssetNode
		{
			if(alias in _assetCache)
			{
				var node:PixelAssetNode = _assetCache[alias];
				//将资源放入队列最前
				_assetArray.splice(_assetArray.indexOf(node),1);
				_assetArray.unshift(node);
				node.mark();//标记时间
				return _assetCache[alias];
			}
			return null;
		}
		
		/**
		 * 
		 * 释放冻结的资源
		 * 
		 * mark标记时间超过最长未使用时间视为冻结资源
		 */
		public function releaseFreeze():void
		{
		}
	}
}