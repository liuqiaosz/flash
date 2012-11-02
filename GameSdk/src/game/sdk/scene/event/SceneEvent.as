package game.sdk.scene.event
{
	import flash.events.Event;

	public class SceneEvent extends Event
	{
		public static const SCENE_DOWNLOAD_COMPLETE:String = "SceneDownloadComplete";
		public static const SCENE_DOWNLOAD_PROGRESS:String = "SceneDownloadProgress";
		public static const SCENE_DOWNLOAD_ERROR:String = "SceneDownloadError";
		
		public var SceneName:String = "";
		public function SceneEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}