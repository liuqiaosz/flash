package bleach.message
{
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessage;

	public class BleachMessage extends PixelMessage
	{
		public static const BLEACH_SYNCSCENEDATA:String = "SyncSceneData";
		public static const BLEACH_TEXTURE_DOWNLOADED:String = "TextureDownloaded";
		public static const BLEACH_WORLD_REDIRECT:String = "WorldRedirect";
//		public static const BLEACH_POPWINDOW_MODEL:String = "PopWindowModel";
//		
//		public static const BLEACH_PRELOAD_SHOW:String = "PreloadShow";
//		public static const BLEACH_PRELOAD_UPDATE:String = "PreloadUpdate";
//		public static const BLEACH_PRELOAD_CLOSE:String = "PreloadClose";
//		
//		public static const BLEACH_CLOSE_PRELOAD_MODEL:String = "ClosePreloadModel";
//		
//		public static const BLEACH_POPWINDOW:String = "PopWindow";
//		public static const BLEACH_POPCLOSE:String = "PopClose";
		public static const BLEACH_DEBUG:String = "Debug";
		
		private var _deallocOld:Boolean = false;
		public function set deallocOld(value:Boolean):void
		{
			_deallocOld = value;
		}
		public function get deallocOld():Boolean
		{
			return _deallocOld;
		}
		public function BleachMessage(msg:String)
		{
			super(msg);
		}
	}
}