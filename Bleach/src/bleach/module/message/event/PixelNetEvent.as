package bleach.module.message.event
{
	import flash.events.Event;

	public class PixelNetEvent extends Event
	{
		public static const NET_EVENT_CONNECTED:String = "Net_Connected";
		public static const NET_EVENT_CONNECTFAILURE:String = "Net_ConnectFailure";
		public static const NET_EVENT_RECIVEPROGRESS:String = "Net_ReciveProgress";
		public static const NET_EVENT_RECIVEDATA:String = "Net_ReciveData";
		
		public var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		public function PixelNetEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}