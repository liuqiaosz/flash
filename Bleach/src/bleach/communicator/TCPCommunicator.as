package bleach.communicator
{
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.protocol.IProtocol;
	import bleach.protocol.IProtocolRequest;
	import bleach.protocol.IProtocolResponse;
	import bleach.protocol.ProtocolConstants;
	import bleach.protocol.ProtocolObserver;
	import bleach.protocol.ProtocolResponse;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import pixel.message.PixelMessage;
	import pixel.utility.BASE64;

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
			try
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
			catch(err:Error)
			{
				debug("数据包接收异常");
				this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_DISCONNECT));
			}
			
		}
		
		/**
		 * 消息分析
		 * 
		 **/
		private function analysisMessage(data:ByteArray):void
		{
			try
			{
				data.position = 0;
				command = data.readInt();
				debug("Recive command[" + command + "]");
				var prototype:Object = ProtocolConstants.findMsgByCommand(command);
				var protocol:IProtocolResponse = null;
				var protocolByte:ByteArray = new ByteArray();
				protocolByte.writeBytes(data,data.position);
				protocolByte.position = 0;
				protocolByte.position = 0;
				if(prototype)
				{
					protocol = new prototype() as IProtocolResponse;
					
				}
				else
				{
					protocol = new ProtocolResponse();
					protocol.id = command;
				}
				
				protocol.setMessage(protocolByte);
				debug(protocol.toInfo);
				ProtocolObserver.instance.broadcast(protocol);
			}
			catch(err:Error)
			{
				debug(err.message + " ID[" + err.errorID + "]");
			}
		}
		
		private function channelConnected(event:Event):void
		{
			_connected = true;
			
			this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_CONNECTED));
		}
		private function channelIoError(event:IOErrorEvent):void
		{
			debug("Connect io异常");
			this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_CONNECT_ERROR));
		}
		private function channelSecurityError(event:SecurityErrorEvent):void
		{
			debug("Connect security异常");
			this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_SECURIRY_ERROR));
			//this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_CONNECT_ERROR));
		}
		
		public function isConnected():Boolean
		{
			return _connected;
		}
		
		public function close():void
		{
			if(_channel)
			{
				_channel.removeEventListener(Event.CONNECT,channelConnected);
				_channel.removeEventListener(IOErrorEvent.IO_ERROR,channelIoError);
				_channel.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,channelSecurityError);
				try
				{
					debug("关闭连接");
					_channel.close();
					_channel = null;
					
				}
				catch(err:Error)
				{
					_channel = null;
				}
				_connected = false;
			}
		}
		public function sendMessage(msg:IProtocolRequest):void
		{
			try
			{
				var data:ByteArray = msg.getMessage() ;
				debug("Send command[" + msg.id + "]");
				_channel.writeInt(data.length - 4);
				_channel.writeBytes(data,0,data.length);
				_channel.flush();
			}
			catch(err:Error)
			{
				debug("发送协议异常," + err.message + " ID[" + err.errorID + "]");
				debug("Socket connected[" + _channel.connected + "]");
				this.dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_DISCONNECT));
			}
		}
		public function sendString(value:String):void
		{}
		
		protected function debug(msg:String):void
		{
			var notify:BleachMessage = new BleachMessage(BleachMessage.BLEACH_DEBUG);
			notify.value = msg;
			dispatchMessage(notify);
		}
	}
}