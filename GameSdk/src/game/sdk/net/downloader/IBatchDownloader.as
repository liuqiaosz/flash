package game.sdk.net.downloader
{
	import flash.events.IEventDispatcher;

	public interface IBatchDownloader extends IEventDispatcher
	{
		function StartBatchDownload(Queue:Vector.<String>):void;
		function PushToQueue(Url:String):void;
	}
}