package pixel.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import pixel.graphic.PixelRenderMode;
	import pixel.io.IPixelIOModule;
	import pixel.message.PixelMessage;
	import pixel.message.PixelMessageBus;
	import pixel.scene.IPixelScene;
	import pixel.transition.IPixelTransition;
	import pixel.transition.PixelTransitionFlipX;
	import pixel.transition.PixelTransitionHelper;
	import pixel.transition.PixelTransitionSquare;
	import pixel.transition.PixelTransitionVars;
	import pixel.transition.event.PixelTransitionEvent;

	use namespace PixelNs;
	
	public class PixelDirector extends EventDispatcher implements IPixelDirector
	{
		public function PixelDirector()
		{
			_cache = new Dictionary();
			_sceneQueue = new Vector.<IPixelScene>();
		}
		
		/**
		 * 主控类开始运行
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function action():void
		{
			_io = PixelLauncher.launcher.ioModule;
		
			PixelMessageBus.Instance.register(PixelMessage.FRAME_UPDATE,frameUpdate);
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
		protected var _activedScene:IPixelScene = null;
		
		/**
		 * 当前切换的场景
		 * 
		 * 
		 **/
		protected var _switchScene:IPixelScene = null;
		
		protected var _sceneQueue:Vector.<IPixelScene> = null;
		/**
		 * 
		 * 是否切换状态
		 * 
		 * 如果切换场景使用了过度效果在效果播放完毕之前该值始终未true
		 **/
		protected var _switching:Boolean = false;
		protected var _square:PixelTransitionSquare = null;
		protected var _io:IPixelIOModule = null;
		/**
		 * 切换场景
		 * 
		 * @param	prototype	要切换的目标场景，如果当前主控的场景缓存是开启状态则优先从缓存查找场景，没有的情况下重新创建
		 * @param	transition	切换过程中是否有过度效果
		 * 
		 **/
		public function switchScene(prototype:Class,transition:int = -1,duration:Number = 1):IPixelScene
		{
			_switchScene = null;
			
			//查找缓存
			if(prototype in _cache)
			{
				_switchScene = _cache[prototype] as IPixelScene;
				//复位操作
				_switchScene.reset();
			}
			
			if(!_switchScene)
			{
				//创建新场景
				_switchScene = new prototype() as IPixelScene;
			}
			
			addScene(_switchScene);
			
			if(transition >= 0)
			{
				//过渡效果
				_square = PixelTransitionHelper.transition(transition,_activedScene,_switchScene,duration);
				if(_square)
				{
					_switching = true;
					_square.addEventListener(PixelTransitionEvent.TRANS_SQUARE_COMPLETE,switchTransitionComplete);
					_square.begin();
				}
			}
			
			if(!_switching)
			{
				if(_activedScene)
				{
					removeScene(_activedScene);
				}
				_activedScene = _switchScene;
			}
			
			return _switchScene;
		}
		
		/**
		 * 场景切换过渡播放完毕
		 * 
		 * 
		 **/
		protected function switchTransitionComplete(event:PixelTransitionEvent):void
		{
			_switching = false;
			_square.removeEventListener(PixelTransitionEvent.TRANS_SQUARE_COMPLETE,switchTransitionComplete);
			_square = null;
			
			removeScene(_activedScene);
			_activedScene = _switchScene;
			_switchScene = null;
		}
		
		
		
		
		protected function addScene(scene:IPixelScene):void
		{
			if(_sceneQueue.indexOf(scene) < 0)
			{
				_sceneQueue.push(scene);
			}
			_io.addSceneToScreen(scene);
		}
		protected function removeScene(scene:IPixelScene):void
		{
			if(_sceneQueue.indexOf(scene) >= 0)
			{
				_sceneQueue.splice(_sceneQueue.indexOf(scene),1);
			}
			_io.removeSceneFromScreen(scene);
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
			for each(var scene:IPixelScene in _sceneQueue)
			{
				scene.update();
			}
			
			
			_io.screenRefresh(_sceneQueue);
			
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