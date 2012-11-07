package mapassistant.event
{
	import flash.events.Event;

	public class NotifyEvent extends Event
	{
		public static const ASSET_SELECTED:String = "AssetSelected";
		public static const WORLD_LAYERUPDATE:String = "WorldLayerUpdate";
		public var Params:Array = [];
		public function NotifyEvent(type:String,Bubbles:Boolean = true)
		{
			super(type,Bubbles);
		}
	}
}