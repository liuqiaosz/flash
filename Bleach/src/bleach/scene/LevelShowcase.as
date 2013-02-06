package bleach.scene
{
	import bleach.communicator.CommMarshal;
	import bleach.module.protocol.ProtocolConstants;
	import bleach.module.protocol.MsgGetLevel;
	import bleach.event.BleachEvent;
	import bleach.view.IViewController;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import pixel.core.PixelLayer;
	import bleach.module.protocol.IProtocol;
	
	/**
	 * 
	 * 关卡选择场景
	 * 
	 **/
	public class LevelShowcase extends GenericScene
	{
		//关卡数据队列
		private var _levelQueue:Vector.<Object> = null;
		//关卡总数
		private var _levelCount:int = 0;
		
		private var _levelShowcase:Dictionary = null;
		
		private var _viewController:IViewController = null;
		
		private var _controller:Class = null;
		public function LevelShowcase(controller:Class = null)
		{
			super(SceneConstants.SCENE_LEVEL);
			_controller = controller;
		}
		
		/**
		 * 初始化
		 * 
		 **/
		override public function initializer():void
		{
			//该场景的视图控制器
			if(_viewController)
			{
				_viewController = new _controller() as IViewController;
				addNode(_viewController as DisplayObject);
			}

			//添加数据通讯监听
			CommMarshal.instance.addMessageListener(ProtocolConstants.MSG_GETLEVELTOTAL,reciveMessage);
			CommMarshal.instance.addEventListener(ProtocolConstants.MSG_GETLEVELINFO,reciveMessage);
		}
		
		/**
		 * 结束对象前的清理函数
		 **/
		override public function dispose():void
		{
			CommMarshal.instance.removeMessageListener(ProtocolConstants.MSG_GETLEVELTOTAL,reciveMessage);
			CommMarshal.instance.removeMessageListener(ProtocolConstants.MSG_GETLEVELINFO,reciveMessage);
		}
		
		protected function reciveMessage(message:IProtocol):void
		{
			switch(message.id)
			{
				case ProtocolConstants.MSG_GETLEVELTOTAL:
					break;
				case ProtocolConstants.MSG_GETLEVELINFO:
					break;
			}
		}
		
		/**
		 * 同步场景数据
		 **/
		override public function syncSceneData():void
		{
			//Loading场景加载
			var notify:BleachEvent = new BleachEvent(BleachEvent.BLEACH_SYNCSCENEDATA);
			dispatchEvent(notify);
			
			//获取关卡数据
			var msg:MsgGetLevel = new MsgGetLevel();
			CommMarshal.instance.sendMessage(msg);
			
			//
		}
		
		/**
		 * 重置状态
		 * 
		 **/
		override public function reset():void
		{
		}
	}
}