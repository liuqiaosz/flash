package game.sdk.net.event
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class NetEvent extends Event
	{
		public static const NET_IOERROR:String = "HttpIoError";
		public static const NET_SECURITYERROR:String = "HttpSecurityError";
		public static const NET_COMPLETE:String = "NetComplete";
		public static const NET_UNCONNECT:String = "NetUnconnect";
		
		public static const TCP_CONNECTED:String = "TCPConnected";
		public static const TCP_DATA:String = "TcpData";
		public static const TCP_SENDCOMPLETE:String = "TcpSendComplete";
		public var _Params:Array = [];
		private var _Message:String = "";
		public function set Message(Value:String):void
		{
			_Message = Value;
		}
		
		private var _Binary:ByteArray = null;
		public function set Binary(Value:ByteArray):void
		{
			_Binary = Value;
		}
		public function get Binary():ByteArray
		{
			return _Binary;
		}
		
		private var _Swf:Object = null;
		public function set Swf(Value:Object):void
		{
			_Swf = Value;
		}
		public function get Swf():Object
		{
			return _Swf;
		}
		
		private var _Image:Bitmap = null;
		public function set Image(Value:Bitmap):void
		{
			_Image = Value;
		}
		public function get Image():Bitmap
		{
			return _Image;
		}
		public function get Message():String
		{
			return _Message
		}
		public function NetEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}