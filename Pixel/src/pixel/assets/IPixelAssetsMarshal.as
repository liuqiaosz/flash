package pixel.assets
{
	import flash.events.IEventDispatcher;

	public interface IPixelAssetsMarshal extends IEventDispatcher
	{
		//将下载任务加入队列
		function pushTaskToQueue(task:PixelAssetTask):void;
		function findAssetsByAlias(alias:String):PixelAssetNode;
		function stop():void;
		function getQueue():Vector.<PixelAssetTask>;
		function getCacheArray():Vector.<PixelAssetTask>;
		function margeCache(cache:Vector.<PixelAssetTask>):void;
	}
}