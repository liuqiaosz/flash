package pixel.ui.control.event
{
	import flash.events.Event;

	public class PixelUIEvent extends Event
	{
		public static const STYLE_DONWLOAD_COMPLETE:String = "StyleDownloadComplete";
		public function PixelUIEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}