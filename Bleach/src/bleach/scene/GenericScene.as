package bleach.scene
{
	import bleach.communicator.CommMarshal;
	import bleach.communicator.NetObserver;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	
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
		
//		public function dealloc():void
//		{
//			
//		}
		
		protected function sendNetMessage(msg:IMsg):void
		{
			var notify:BleachNetMessage = new BleachNetMessage(BleachNetMessage.BLEACH_NET_SENDMESSAGE);
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
			NetObserver.instance.addListener(command,callback);
		}
		protected function removeNetListener(command:int,callback:Function):void
		{
			NetObserver.instance.removeListener(command,callback);
		}
			
	}
}