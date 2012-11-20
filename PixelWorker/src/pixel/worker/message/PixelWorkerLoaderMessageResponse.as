package pixel.worker.message
{
	public class PixelWorkerLoaderMessageResponse extends PixelWorkerMessageResponse
	{
		private var _total:int = 0;
		public function set total(value:int):void
		{
			_total = value;
		}
		public function get total():int
		{
			return _total;
		}
		
		private var _loaded:int = 0;
		public function set loaded(value:int):void
		{
			_loaded = value;
		}
		public function get loaded():int
		{
			return _loaded;
		}
		
		private var _shareMemory:Boolean = false;
		public function set shareMemory(value:Boolean):void
		{
			_shareMemory = value;
		}
		public function get shareMemory():Boolean
		{
			return _shareMemory;
		}
		
		private var _url:String = "";
		public function set url(value:String):void
		{
			_url = value;
		}
		public function get url():String
		{
			return _url;
		}
		public function PixelWorkerLoaderMessageResponse(type:int = 0)
		{
			super(type);
		}
	}
}