package pixel.assets
{
	import flash.events.IEventDispatcher;

	public interface IAssetsLoader extends IEventDispatcher
	{
		//将下载任务加入队列
		function pushTaskToQueue(task:AssetTask):void;
	}
}