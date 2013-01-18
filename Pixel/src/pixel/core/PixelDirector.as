package pixel.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import pixel.graphic.PixelRenderMode;
	import pixel.io.IPixelIOModule;
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessage;
	import pixel.message.PixelMessageBus;

	use namespace PixelNs;
	
	public class PixelDirector extends EventDispatcher implements IPixelDirector
	{
		private var _contentLayer:Sprite = null;
		private var _topLayer:Sprite = null;
		public function PixelDirector()
		{
			
		}
		
		public function initializer():void
		{
			//_cache = new Dictionary();
			//_sceneQueue = new Vector.<DisplayObject>();
			_contentLayer = new Sprite();
			_topLayer = new Sprite();
			gameStage.addChild(_contentLayer);
			gameStage.addChild(_topLayer);
		}
		
		/**
		 * 主控类开始运行
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function action():void
		{
			//_io = PixelLauncher.launcher.ioModule;
		
			PixelMessageBus.instance.register(PixelMessage.FRAME_UPDATE,frameUpdate);
		}
		
		/**
		 * 
		 * 场景缓存
		 **/
		protected var _cache:Dictionary = null;
		
		/**
		 * 
		 * 当前激活场景
		 **/
		protected var _activedScene:DisplayObject = null;
		
		/**
		 * 当前切换的场景
		 * 
		 * 
		 **/
		//protected var _switchScene:IPixelLayer = null;
		
		//protected var _sceneQueue:Vector.<DisplayObject> = null;
		/**
		 * 
		 * 是否切换状态
		 * 
		 * 如果切换场景使用了过度效果在效果播放完毕之前该值始终未true
		 **/
		//protected var _switching:Boolean = false;
		protected var _io:IPixelIOModule = null;
		/**
		 * 切换场景
		 * 
		 * @param	prototype	要切换的目标场景，如果当前主控的场景缓存是开启状态则优先从缓存查找场景，没有的情况下重新创建
		 * @param	transition	切换过程中是否有过度效果
		 * 
		 **/
		public function switchScene(prototype:Class,transition:int = -1,duration:Number = 1):void
		{
			var switchScene:IPixelLayer = null;
			//查找缓存
			if(prototype in _cache)
			{
				switchScene = _cache[prototype] as IPixelLayer;
				//复位操作
				switchScene.reset();
			}
			
			if(!switchScene)
			{
				//创建新场景
				switchScene = new prototype() as IPixelLayer;
				_cache[prototype] = switchScene;
			}
			swapScene(switchScene as DisplayObject);
		}
		
		public function switchSceneById(id:String):void
		{
//			var scene:IPixelLayer = null;
//			for each(scene in _sceneQueue)
//			{
//				if(scene.id == id)
//				{
//					swapScene(scene as DisplayObject);
//					break;
//				}
//			}
		}
		
		/**
		 * 场景切换过渡播放完毕
		 * 
		 * 
		 **/
//		protected function switchTransitionComplete(event:PixelTransitionEvent):void
//		{
//			_switching = false;
//			_square.removeEventListener(PixelTransitionEvent.TRANS_SQUARE_COMPLETE,switchTransitionComplete);
//			_square = null;
//			
//			removeScene(_activedScene);
//			_activedScene = _switchScene;
//			_switchScene = null;
//		}
		
		protected function swapScene(newScene:DisplayObject,oldDealloc:Boolean = true):void
		{
			if(_activedScene)
			{
				removeScene(_activedScene);
			}
			_activedScene = newScene;
			addScene(newScene);
		}
		private var _sceneQueue:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		protected function addScene(scene:DisplayObject):void
		{
			if(_sceneQueue.indexOf(scene) < 0)
			{
				_sceneQueue.push(scene);
			}
			//this.gameStage.addChild(scene as DisplayObject);
			_contentLayer.addChild(scene as DisplayObject);
			//_io.addSceneToScreen(scene);
		}
		protected function removeScene(scene:DisplayObject):void
		{
			if(_sceneQueue.indexOf(scene) >= 0)
			{
				_sceneQueue.splice(_sceneQueue.indexOf(scene),1);
			}
			_contentLayer.removeChild(scene as DisplayObject);
			//_io.removeSceneFromScreen(scene);
		}
		
		protected function addSceneTop(scene:DisplayObject):void
		{
			if(_sceneQueue.indexOf(scene) < 0)
			{
				_sceneQueue.push(scene);
			}
			_topLayer.addChild(scene);
		}
		protected function removeSceneTop(scene:DisplayObject):void
		{
			if(_sceneQueue.indexOf(scene) >= 0)
			{
				_sceneQueue.splice(_sceneQueue.indexOf(scene),1);
			}
			if(_topLayer.contains(scene))
			{
				_topLayer.removeChild(scene);
			}
		}
		
		protected function get gameStage():Stage
		{
			return PixelLauncher.launcher.gameStage;
		}
		
		/**
		 * 更新当前状态
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function frameUpdate(message:PixelMessage):void
		{
			
//			if(_switching)
//			{
//				//正在切换过渡
//				return;
//			}
//			
//			if(_activedScene)
//			{
//				//更新状态
//				_activedScene.update();
//			}
//			for each(var scene:IPixelLayer in _sceneQueue)
//			{
//				scene.update();
//			}
			
			//_io.screenRefresh(_sceneQueue);
		}
		
		public function addMessageListener(type:String,callback:Function):void
		{
			PixelMessageBus.instance.register(type,callback);
		}
		public function removeMessageListener(type:String,callback:Function):void
		{
			PixelMessageBus.instance.unRegister(type,callback);
		}
		public function dispatchMessage(msg:IPixelMessage):void
		{
			PixelMessageBus.instance.dispatchMessage(msg);
		}
		/**
		 * 暂停当前运行
		 * 
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function pause():void
		{
		}
		
		/**
		 * 结束运行
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function end():void
		{
		}
	}
}