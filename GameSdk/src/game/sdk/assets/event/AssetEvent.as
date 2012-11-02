package game.sdk.assets.event
{
	import flash.events.Event;

	public class AssetEvent extends Event
	{
		public static const DOWNLOADCOMPLETE:String = "AssetDownloadComplete";
		public static const BATCHDOWNLOADCOMPLETE:String = "BatchAssetDownloadComplete";
		
		public var Id:String = "";
		
		public function AssetEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}