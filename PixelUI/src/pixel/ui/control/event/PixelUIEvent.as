package pixel.ui.control.event
{
	import flash.events.Event;

	public class PixelUIEvent extends Event
	{
		public static const STYLE_DONWLOAD_COMPLETE:String = "StyleDownloadComplete";
		
		private var _value:Object = null;
		public function set value(value:Object):void
		{
			_value = value;
		}
		public function get value():Object
		{
			return _value;
		}
		public function PixelUIEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}