package bleach
{
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	import bleach.module.message.MsgHeartBeat;
	import bleach.module.message.MsgIdConstants;
	
	import pixel.core.PixelSprite;
	
	/**
	 * 心跳器
	 **/
	public class HeartBeat extends BleachNode
	{
		private var _running:Boolean = false;
		//心跳间隔
		private var _heartBeatTime:int = 0;
		//心跳超时
		private var _heartBeatTimeOut:int = 0;
		private var lastHeartbeat:Number = 0;//new Date().time;
		private var heartbeat:MsgHeartBeat = new MsgHeartBeat();
		//等待心跳回应
		private var waitHeartbeatResp:Boolean = false;
		private var _heartbeat:MsgHeartBeat = new MsgHeartBeat();
		private var requestMessage:BleachNetMessage = new BleachNetMessage(BleachNetMessage.BLEACH_NET_SENDMESSAGE);
		
		public function HeartBeat(hbtime:int,hbot:int)
		{
			super();
			_heartBeatTime = hbtime;
			_heartBeatTimeOut = hbot;
			
		}
		
		public function start():void
		{
			addNetListener(MsgIdConstants.MSG_HEARTBEAT_RESP,heartbeatResponse);
			_running = true;
		}
		public function pause():void
		{
			_running = false;
		}
		
		/**
		 * 心跳报回应
		 * 
		 **/
		private function heartbeatResponse(msg:IMsg):void
		{
			waitHeartbeatResp = false;
			trace("心跳回应");
		}
		
		/**
		 * 发送心跳包
		 * 
		 **/
		private function heartbeatRequest(time:Number):void
		{
			lastHeartbeat = time;
			_heartbeat.timestamp = lastHeartbeat;
			requestMessage.value = _heartbeat;
			//_channel.sendMessage(_heartbeat);
			dispatchMessage(requestMessage);
			waitHeartbeatResp = true;
		}
		
		override public function update():void
		{
			if(!_running)
			{
				return;
			}
			var now:Number = new Date().time;
			if(!waitHeartbeatResp)
			{
				if(now - lastHeartbeat >= _heartBeatTime)
				{
					//到达发送心跳间隔
					heartbeatRequest(now);
				}
			}
			else
			{
				//检查等待回应是否超时
				if(now - lastHeartbeat >= _heartBeatTimeOut)
				{
					//心跳回应超时
					//重新链接服务器
					dispatchMessage(new BleachNetMessage(BleachNetMessage.BLEACH_NET_RECONNECT));
					//停止当前心跳
					this.pause();
				}
			}
		}
		
		override public function dispose():void
		{
			removeNetListener(MsgIdConstants.MSG_HEARTBEAT_RESP,heartbeatResponse);
		}
	}
}