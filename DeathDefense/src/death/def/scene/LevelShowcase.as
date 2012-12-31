package death.def.scene
{
	import death.def.communication.CommMarshal;
	import death.def.communication.MessageConstants;
	import death.def.event.BleachDefenseEvent;
	import death.def.view.IViewController;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import pixel.core.PixelLayer;
	import pixel.net.msg.IPixelNetMessage;
	
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
			CommMarshal.instance.addMessageListener(MessageConstants.MSG_GETLEVELTOTAL,reciveMessage);
			CommMarshal.instance.addEventListener(MessageConstants.MSG_GETLEVELINFO,reciveMessage);
			
			//场景数据
		}
		
		/**
		 * 结束对象前的清理函数
		 **/
		override public function dispose():void
		{
			CommMarshal.instance.removeMessageListener(MessageConstants.MSG_GETLEVELTOTAL,reciveMessage);
			CommMarshal.instance.removeMessageListener(MessageConstants.MSG_GETLEVELINFO,reciveMessage);
		}
		
		protected function reciveMessage(message:IPixelNetMessage):void
		{
			switch(message.id)
			{
				case MessageConstants.MSG_GETLEVELTOTAL:
					//更新关卡视图
					break;
				case MessageConstants.MSG_GETLEVELINFO:
					break;
			}
		}
		
		/**
		 * 同步场景数据
		 **/
		override public function syncSceneData():void
		{
			var notify:BleachDefenseEvent = new BleachDefenseEvent(BleachDefenseEvent.BLEACH_SYNCSCENEDATA);
			dispatchEvent(notify);
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