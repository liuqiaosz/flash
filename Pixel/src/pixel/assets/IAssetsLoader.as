package pixel.assets
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.IEventDispatcher;

	public interface IAssetsLoader extends IEventDispatcher
	{
		//将下载任务加入队列
		function pushTaskToQueue(task:AssetTask):void;
		function findAssetsByAlias(alias:String):Loader;
	}
}