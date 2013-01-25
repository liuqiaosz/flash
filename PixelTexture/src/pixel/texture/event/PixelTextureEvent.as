package pixel.texture.event
{
	import flash.events.Event;

	public class PixelTextureEvent extends Event
	{
		public static const PACKAGE_DECODE_SUCCESS:String = "PackageDecodeSuccess";
		public function PixelTextureEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}