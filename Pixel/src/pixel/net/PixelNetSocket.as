package pixel.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import pixel.error.PixelNetError;
	import pixel.net.event.PixelNetEvent;
	import pixel.net.msg.IPixelNetMessage;

	public class PixelNetSocket extends EventDispatcher implements IPixelNetConnection
	{
		public static const CHARSET_GBK:String = "GBK";
		public static const CHARSET_UTF8:String = "utf-8";
		private var _client:Socket = null;
		private var _ip:String = "";
		private var _port:int = 0;
		private var _charset:String = null;
		private var _isConnected:Boolean = false;
		public function PixelNetSocket(ip:String,port:int,encode:String = CHARSET_UTF8)
		{
			super();
			_ip = ip;
			_port = port;
			_charset = encode;
		}
		
		public function connect():void
		{
			if(_ip == "" || null == _ip || _port  == 0)
			{
				throw new PixelNetError(PixelNetError.NET_ERROR_ADDR);
			}
			
			if(_client)
			{
				close();	
			}
			
			try
			{
				_client = new Socket();
				_client.addEventListener(Event.CONNECT,onConnect);
				_client.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
				_client.addEventListener(ProgressEvent.SOCKET_DATA,onRecive);
				_client.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				_client.connect(_ip,_port);
				//_client.addEventListener(
			}
			catch(err:Error)
			{
				var notify:PixelNetEvent = new PixelNetEvent(PixelNetEvent.NET_EVENT_CONNECTFAILURE);
				dispatchEvent(notify);
			}
		}
		
		protected function onConnect(event:Event):void
		{
			dispatchEvent(new PixelNetEvent(PixelNetEvent.NET_EVENT_CONNECTED));
			_isConnected = true;
		}
		protected function onIOError(event:IOErrorEvent):void
		{
			var notify:PixelNetEvent = new PixelNetEvent(PixelNetEvent.NET_EVENT_CONNECTFAILURE);
			notify.value = event.errorID;
			dispatchEvent(notify);
		}
		
		protected function onRecive(event:ProgressEvent):void
		{
			
		}

		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			var notify:PixelNetEvent = new PixelNetEvent(PixelNetEvent.NET_EVENT_CONNECTFAILURE);
			notify.value = event.errorID;
			dispatchEvent(notify);
		}
		
		public function close():void
		{
			if(_client)
			{
				_client.close();
				_client.removeEventListener(Event.CONNECT,onConnect);
				_client.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
				_client.removeEventListener(ProgressEvent.SOCKET_DATA,onRecive);
				_client.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				_client = null;
			}
		}
		
		public function sendMessage(msg:IPixelNetMessage):void
		{
			if(_client && _isConnected)
			{
				_client.writeMultiByte(msg.getMessage(),_charset)
				_client.flush();
			}
		}
		
		public function sendString(value:String):void
		{
			if(_client && _isConnected)
			{
				_client.writeMultiByte(value,_charset)
				_client.flush();
			}
		}
	}
}