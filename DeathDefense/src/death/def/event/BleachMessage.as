package death.def.event
{
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessage;

	public class BleachMessage extends PixelMessage
	{
		public static const BLEACH_SYNCSCENEDATA:String = "SyncSceneData";
		public static const BLEACH_TEXTURE_DOWNLOADED:String = "TextureDownloaded";
		public static const BLEACH_WORLD_REDIRECT:String = "WorldRedirect";
		
		public function BleachMessage(msg:String,target:Object)
		{
			super(msg,target);
		}
	}
}