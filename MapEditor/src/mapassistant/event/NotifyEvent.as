package mapassistant.event
{
	import flash.events.Event;

	public class NotifyEvent extends Event
	{
		public static const ASSET_SELECTED:String = "AssetSelected";
		public static const WORLD_LAYERUPDATE:String = "WorldLayerUpdate";
		public static const LAYER_DELETE:String = "LayerDelete";
		public static const OBJECT_SELECTED:String = "ObjectSelected";
		public static const ASSETBLOCK_SAVE:String = "AssetBlockSave";
		public static const ASSETBLOCK_SELECT:String = "AssetBlockSelected";
		public static const LAYER_ACTIVE:String = "LayerActive";
		public var Params:Array = [];
		public function NotifyEvent(type:String,Bubbles:Boolean = true)
		{
			super(type,Bubbles);
		}
	}
}