package game.sdk.assets
{
	import flash.events.IEventDispatcher;

	public interface IAssetLibraryManager extends IEventDispatcher
	{
		function DownloadAssetLibrary(Asset:IAssetLibrary):void;
		function BatchDownloadAssetLibrary(AssetLibs:Vector.<IAssetLibrary>):void;
		//依据名称获取资源库
		function FindAssetLibraryById(Id:String):IAssetLibrary;
	}
}