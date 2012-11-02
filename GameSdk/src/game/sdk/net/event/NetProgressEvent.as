package game.sdk.net.event
{
	public class NetProgressEvent extends NetEvent
	{
		public static const NET_PROGRESS:String = "NetProgress";
		private var _Total:int = 0;
		public function set Total(Value:int):void
		{
			_Total = Value;
		}
		public function get Total():int
		{
			return _Total;
		}
		private var _Loaded:int = 0;
		public function set Loaded(Value:int):void
		{
			_Loaded = Value;
		}
		public function get Loaded():int
		{
			return _Loaded;
		}
		public function NetProgressEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}