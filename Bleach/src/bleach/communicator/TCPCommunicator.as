package bleach.communicator
{
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	import bleach.module.message.IMsgRequest;
	import bleach.module.message.IMsgResponse;
	import bleach.module.message.MsgConstants;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

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
			_channel.addEventListener(ProgressEvent.SOCKET_DATA,channelProgressData);
			_channel.connect(ip,port);
		}
		
		//是否断包，沾包处理
//		private var process:Boolean = false;
		private var packLength:int = 0;
		private var length:int = 0;
		private var dataBuffer:ByteArray = new ByteArray();
		private var command:int = 0;
//		private var availableLength:int = 0;
		private var position:int = 0;
		private var remainBuffer:ByteArray = new ByteArray();
		//private var channelBuffer:ByteArray = new ByteArray();
		/**
		 * 有数据包到达
		 **/
		private function channelProgressData(event:ProgressEvent):void
		{
			//将所有数据读入接收缓存
			_channel.readBytes(dataBuffer,0,event.bytesLoaded);
			while(dataBuffer.length >= 4)
			{
				position = dataBuffer.length;
				dataBuffer.position = 0;
				//4字节ID长度
				packLength = dataBuffer.readUnsignedInt() + 4;
				
				if(dataBuffer.bytesAvailable >= packLength)
				{
					//包接收完整
					var data:ByteArray = new ByteArray();
					dataBuffer.readBytes(data,0,packLength);
					//dataBuffer.position += packLength;
					analysisMessage(data);
					if(dataBuffer.bytesAvailable > 0)
					{
						//读取剩余数据
						remainBuffer.readBytes(dataBuffer,dataBuffer.position,dataBuffer.bytesAvailable);
						dataBuffer.clear();
						dataBuffer.writeBytes(remainBuffer);
						remainBuffer.clear();
					}
					else
					{
						dataBuffer.clear();
					}
				}
				else
				{
					//不完整包，恢复位置，等待下一个数据包到达
					dataBuffer.position = position;
					break;
				}
			}
		}
		
		/**
		 * 消息分析
		 * 
		 **/
		private function analysisMessage(data:ByteArray):void
		{
			data.position = 0;
			command = data.readInt();
			trace("Command[" + command + "] Reponse...");
			var prototype:Object = MsgConstants.findMsgById(command);
			if(prototype)
			{
				var msg:IMsgResponse = new prototype() as IMsgResponse;
				msg.setMessage(data);
				
				NetObserver.instance.broadcast(msg);
			}
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
		public function sendMessage(msg:IMsgRequest):void
		{
			var data:ByteArray = msg.getMessage() ;
			_channel.writeInt(data.length - 4);
			_channel.writeBytes(data,0,data.length);
			_channel.flush();
		}
		public function sendString(value:String):void
		{}
	}
}