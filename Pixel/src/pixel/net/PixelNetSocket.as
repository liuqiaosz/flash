package pixel.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import pixel.error.PixelNetError;
	import pixel.net.event.PixelNetEvent;
	import pixel.net.msg.IPixelNetMessage;

	public class PixelNetSocket extends EventDispatcher implements IPixelNetConnection
	{
		public static const CHARSET_GBK:String = "GBK";
		public static const CHARSET_UTF8:String = "utf-8";
		private var _channel:Socket = null;
		private var _ip:String = "";
		private var _port:int = 0;
		private var _charset:String = null;
		private var _isConnected:Boolean = false;
		private var _readBuffer:ByteArray = null;
		public function PixelNetSocket()
		{
			super();
			_readBuffer = new ByteArray();
		}
		
		public function connect(ip:String,port:int,encode:String = CHARSET_UTF8):void
		{
			_ip = ip;
			_port = port;
			_charset = encode;
			if(_ip == "" || null == _ip || _port  == 0)
			{
				throw new PixelNetError(PixelNetError.NET_ERROR_ADDR);
			}
			
			if(_channel)
			{
				close();	
			}
			
			try
			{
				_channel = new Socket();
				_channel.addEventListener(Event.CONNECT,onConnect);
				_channel.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
				_channel.addEventListener(ProgressEvent.SOCKET_DATA,onRecive);
				_channel.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				_channel.connect(_ip,_port);
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
		
		/**
		 * 缓存区有数据到达
		 * 
		 **/
		protected function onRecive(event:ProgressEvent):void
		{
			if(_channel.bytesAvailable)
			{
				_channel.readBytes(_readBuffer,0,_channel.bytesAvailable);
				if(validateMessage(_readBuffer))
				{
					var msg:ByteArray = new ByteArray();
					_readBuffer.readBytes(msg,0,_readBuffer.length);
					_readBuffer.clear();
					msg.position = 0;
					dataRecived(msg);
					//清空接收缓存
					
				}
			}
		}
		
		protected function dataRecived(data:ByteArray):void
		{
			var notify:PixelNetEvent = new PixelNetEvent(PixelNetEvent.NET_EVENT_RECIVEDATA);
			notify.value = data;
			dispatchEvent(notify);
		}
		
		/**
		 * 数据包校验
		 * 
		 * 这里负责由项目的各自的业务通讯进行重写。判断包的完整性和正确性
		 **/
		protected function validateMessage(buffer:ByteArray):Boolean
		{
			return true;
		}

		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			var notify:PixelNetEvent = new PixelNetEvent(PixelNetEvent.NET_EVENT_CONNECTFAILURE);
			notify.value = event.errorID;
			dispatchEvent(notify);
		}
		
		public function close():void
		{
			if(_channel)
			{
				_channel.close();
				_channel.removeEventListener(Event.CONNECT,onConnect);
				_channel.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
				_channel.removeEventListener(ProgressEvent.SOCKET_DATA,onRecive);
				_channel.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				_channel = null;
			}
		}
		
		public function sendMessage(msg:IPixelNetMessage):void
		{
			if(_channel && _isConnected)
			{
				_channel.writeMultiByte(msg.getMessage(),_charset)
				_channel.flush();
			}
		}
		
		public function sendString(value:String):void
		{
			if(_channel && _isConnected)
			{
				_channel.writeMultiByte(value,_charset)
				_channel.flush();
			}
		}
	}
}