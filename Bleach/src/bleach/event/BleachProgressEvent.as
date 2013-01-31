package bleach.event
{
	import flash.events.Event;

	public class BleachProgressEvent extends Event
	{
		public static const BLEACH_DOWNLOAD_PROGRESS:String = "DownloadProgress";
		private var _total:Number = 0;
		public function set total(value:Number):void
		{
			_total = value;
		}
		public function get total():Number
		{
			return _total;
		}
		
		private var _loaded:Number = 0;
		public function set loaded(value:Number):void
		{
			_loaded = value;
		}
		public function get loaded():Number
		{
			return _loaded;
		}
		public function BleachProgressEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}