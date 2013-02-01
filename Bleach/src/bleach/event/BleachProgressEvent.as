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
		
		private var _taskTotal:Number = 0;
		public function set taskTotal(value:Number):void
		{
			_taskTotal = value;
		}
		public function get taskTotal():Number
		{
			return _taskTotal;
		}
		private var _taskLoaded:Number = 0;
		public function set taskLoaded(value:Number):void
		{
			_taskLoaded = value;
		}
		public function get taskLoaded():Number
		{
			return _taskLoaded;
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