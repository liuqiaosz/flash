package game.sdk.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import game.sdk.net.event.NetEvent;

	public class TCPConnection extends EventDispatcher implements ITCPConnection
	{
		private var _Host:String = "";
		private var _Port:int = 0;
		private var _Connection:Socket = null;
		private var _Connected:Boolean = false;
		
		public function get Connected():Boolean
		{
			return _Connected;
		}
		
		public function TCPConnection()
		{
			super();
		}
		
		public function Connect(Addr:String,Port:int):void
		{
			_Host = Addr;
			_Port = Port;
			if(_Connection == null)
			{
				_Connection = new Socket();
				_Connection.addEventListener(Event.CONNECT,OnConnect);
				_Connection.addEventListener(Event.CLOSE,OnClose);
				_Connection.addEventListener(IOErrorEvent.IO_ERROR,OnIOError);
				_Connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,OnSecurityError);
				_Connection.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS,OnWriteProgress);
				_Connection.addEventListener(ProgressEvent.SOCKET_DATA,OnSocketData);
				try
				{
					_Connected = true;
					_Connection.connect(Addr,Port);
				}
				catch(Err:Error)
				{
					_Connected = false;
					dispatchEvent(new NetEvent(NetEvent.NET_UNCONNECT));
				}
			}
		}
		
		private function OnSocketData(event:ProgressEvent):void
		{
			if(_Connection.bytesAvailable > 0)
			{
				var Data:ByteArray = new ByteArray();
				_Connection.readBytes(Data,0,_Connection.bytesAvailable);
				var Notify:NetEvent = new NetEvent(NetEvent.TCP_DATA);
				Notify.Binary = Data;
				dispatchEvent(Notify);
			}
		}
		
		private function OnSecurityError(event:SecurityErrorEvent):void
		{
			_Connected = false;
			dispatchEvent(new NetEvent(NetEvent.NET_UNCONNECT));
		}
		
		private function OnIOError(event:IOErrorEvent):void
		{
			_Connected = false;
			dispatchEvent(new NetEvent(NetEvent.NET_IOERROR));
		}
		
		private function OnClose(event:Event):void
		{
		}
		
		private function OnConnect(event:Event):void
		{
			dispatchEvent(new NetEvent(NetEvent.TCP_CONNECTED));
			_Connected = true;
		}
		
		private function OnWriteProgress(event:OutputProgressEvent):void
		{
			if(event.bytesPending == 0)
			{
				dispatchEvent(new NetEvent(NetEvent.TCP_SENDCOMPLETE));
			}
		}
		
		public function Request(Attr:IAttribute = null):void
		{
			if(Attr)
			{
				var Data:ByteArray = Attr.GetPakcage() as ByteArray;
				if(Data && Data.length > 0 && _Connected)
				{
					_Connection.writeBytes(Data,0,Data.length);
					_Connection.flush();
				}
			}
		}
		
		public function Close():void
		{
			if(_Connection)
			{
				_Connected = false;
				_Connection.close();
				_Connection.removeEventListener(Event.CONNECT,OnConnect);
				_Connection.removeEventListener(Event.CLOSE,OnClose);
				_Connection.removeEventListener(IOErrorEvent.IO_ERROR,OnIOError);
				_Connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,OnSecurityError);
				_Connection.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS,OnWriteProgress);
				_Connection.removeEventListener(ProgressEvent.SOCKET_DATA,OnSocketData);
				_Connection = null;
			}
		}
	}
}