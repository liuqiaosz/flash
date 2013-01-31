package bleach.event
{
	import flash.events.Event;

	public class BleachEvent extends Event
	{
		//同步场景数据
		public static const BLEACH_SYNCSCENEDATA:String = "SyncSceneData";
		
		public static const BLEACH_TEXTURE_DOWNLOADED:String = "TextureDownloaded";
		
		public static const BLEACH_WORLD_REDIRECT:String = "WorldRedirect";
		public static const BLEACH_INIT_COMPLETE:String = "InitializeComplete";
		
		public static const BLEACH_FLOW_SELECTED:String = "FlowItemSelected";
		
		public static const BLEACH_SCENE_DOWNLOAD_COMPLETE:String = "SceneDownloadComplete";
		public static const BLEACH_SCENE_DOWNLOAD_FAILURE:String = "SceneDownloadFailure";
		
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		
		public function BleachEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}