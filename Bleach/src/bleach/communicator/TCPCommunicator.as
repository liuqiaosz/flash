package bleach.communicator
{
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	public class TCPCommunicator extends GenericCommunicator implements ITCPCommunicator
	{
		private var _connected:Boolean = false;
		private var _channel:Socket = null;
		public function TCPCommunicator()
		{
			super();
		}
		
		/**
		 * 
		 * 连接网络
		 * 
		 **/
		public function connect(ip:String = "",port:int = 9090,encode:String = ""):void
		{
			if(_channel)
			{
				close();
			}
			_channel = new Socket();
			_channel.addEventListener(Event.CONNECT,channelConnected);
			_channel.addEventListener(IOErrorEvent.IO_ERROR,channelIoError);
			_channel.addEventListener(SecurityErrorEvent.SECURITY_ERROR,channelSecurityError);
			_channel.connect(ip,port);
		}
		
		private function channelConnected(event:Event):void
		{
			_connected = true;
			this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_CONNECTED));
		}
		private function channelIoError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		private function channelSecurityError(event:SecurityErrorEvent):void
		{
			trace(event.text);
		}
		
		public function isConnected():Boolean
		{
			return _connected;
		}
		
		public function close():void
		{
			if(_channel)
			{
				_channel.close();
				_channel.removeEventListener(Event.CONNECT,channelConnected);
				_channel.removeEventListener(IOErrorEvent.IO_ERROR,channelIoError);
				_channel.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,channelSecurityError);
				_channel = null;
				_connected = false;
			}
		}
		public function sendMessage(msg:IMsg):void
		{}
		public function sendString(value:String):void
		{}
	}
}