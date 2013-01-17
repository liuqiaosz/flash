package bleach.message
{
	import pixel.message.PixelMessage;

	public class BleachLoadingMessage extends PixelMessage
	{
		public static const BLEACH_LOADING_SHOW:String = "LoadingShow";
		public static const BLEACH_LOADING_UPDATE:String = "LoadingUpdate";
		public static const BLEACH_LOADING_HIDE:String = "LoadingHide";
		public static const BLEACH_LOADING_END:String = "LoadingEnd";
		
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
		
		public function BleachLoadingMessage(type:String)
		{
			super(type);
		}
		
	}
}