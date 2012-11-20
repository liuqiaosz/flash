package pixel.assets.event
{
	import flash.events.Event;

	public class PixelAssetEvent extends Event
	{
		public static const ASSET_COMPLETE:String = "AssetComplete";
		public static const ASSET_PROGRESS:String = "AssetProgress";
		public static const ASSET_ERROR:String = "AssetError";
		
		public function PixelAssetEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}