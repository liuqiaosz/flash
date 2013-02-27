package bleach.scene
{
	import bleach.cfg.BleachErrorCode;
	import bleach.communicator.CommMarshal;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.protocol.IProtocol;
	import bleach.protocol.ProtocolObserver;
	import bleach.protocol.event.ProtocolMessage;
	
	import pixel.core.PixelLayer;

	public class GenericScene extends PixelLayer implements IScene
	{
		private var _pause:Boolean = false;
		public function GenericScene(id:String = "")
		{
			super(id);
		}
		
		/**
		 * 从服务端同步场景数据
		 * 
		 **/
		public function syncSceneData():void
		{
		}
		
		public function unactived():void
		{
			_pause = true;
		}
		public function actived():void
		{
			_pause = false;
		}
	
		override public final function update():void
		{
			if(!_pause)
			{
				super.update();
				sceneUpdate();
			}
		}
		
		protected function getErrorDescByCode(code:int):String
		{
			return BleachErrorCode.getDescByCode(code);
		}
		
//		public function dealloc():void
//		{
//			
//		}
		
		protected function sendNetMessage(msg:IProtocol):void
		{
			var notify:ProtocolMessage = new ProtocolMessage(ProtocolMessage.BLEACH_NET_SENDMESSAGE);
			notify.value = msg;
			dispatchMessage(notify);
		}
		protected function debug(info:String):void
		{
			var debugMsg:BleachMessage = new BleachMessage(BleachMessage.BLEACH_DEBUG);
			debugMsg.value = info;
			dispatchMessage(debugMsg);
		}
		
		protected function sceneUpdate():void
		{}
		
		protected function addNetListener(command:int,callback:Function):void
		{
			ProtocolObserver.instance.addListener(command,callback);
		}
		protected function removeNetListener(command:int,callback:Function):void
		{
			ProtocolObserver.instance.removeListener(command,callback);
		}
			
	}
}