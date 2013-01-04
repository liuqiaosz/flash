package death.def.event
{
	import flash.events.Event;

	public class BleachDefenseEvent extends Event
	{
		//同步场景数据
		public static const BLEACH_SYNCSCENEDATA:String = "SyncSceneData";
		
		public static const BLEACH_TEXTURE_DOWNLOADED:String = "TextureDownloaded";
		
		public static const BLEACH_WORLD_REDIRECT:String = "WorldRedirect";
		
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		
		public function BleachDefenseEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}