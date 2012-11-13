package pixel.core
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import pixel.scene.IPixelScene;
	import pixel.transition.IPixelTransition;
	import pixel.transition.PixelTransitionFlipX;
	import pixel.transition.PixelTransitionSquare;
	import pixel.transition.PixelTransitionVars;
	import pixel.transition.event.PixelTransitionEvent;

	public class PixelDirector extends EventDispatcher implements IPixelDirector
	{
		public function PixelDirector()
		{
		}
		
		/**
		 * 主控类开始运行
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function action():void
		{
			_cache = new Dictionary();
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
		 * 
		 * 是否切换状态
		 * 
		 * 如果切换场景使用了过度效果在效果播放完毕之前该值始终未true
		 **/
		protected var _switching:Boolean = false;
		protected var _player:PixelTransitionSquare = null;
		
		/**
		 * 切换场景
		 * 
		 * @param	prototype	要切换的目标场景，如果当前主控的场景缓存是开启状态则优先从缓存查找场景，没有的情况下重新创建
		 * @param	transition	切换过程中是否有过度效果
		 * 
		 **/
		public function switchScene(prototype:Class,transition:int = -1):void
		{
			var _scene:IPixelScene = null;
			
			//查找缓存
			if(prototype in _cache)
			{
				_scene = _cache[prototype] as IPixelScene;
				//复位操作
				_scene.reset();
			}
			
			if(!_scene)
			{
				//创建新场景
				_scene = new prototype() as IPixelScene;
			}
			
			if(transition)
			{
				//设置标记
				_switching = true;
				var queue:Array = [];
				
				//当前场景往左滑出主屏幕
				var param:PixelTransitionVars = new PixelTransitionVars(_activedScene,2);
				param.x = PixelLauncher.screen.screenWidth * -1;
				param.y = PixelLauncher.screen.screenHeight * -1;
				var flip:PixelTransitionFlipX = new PixelTransitionFlipX(param);
				queue.push(flip);
				
				//激活场景从屏幕右边划入主屏幕
				param = new PixelTransitionVars(_scene,2);
				//设置激活场景的坐标为右边屏幕
				_scene.x = PixelLauncher.screen.screenWidth;
				_scene.y = PixelLauncher.screen.screenHeight;
				//设定目标为屏幕左上角
				param.x = 0;
				param.y = 0;
				
				flip = new PixelTransitionFlipX(param);
				queue.push(flip);
				
				//批处理
				_player = new PixelTransitionSquare();

				_player.addEventListener(PixelTransitionEvent.TRANS_COMPLETE,switchTransitionComplete);
				_player.begin(queue);
			}
		}
		
		/**
		 * 场景切换过渡播放完毕
		 * 
		 * 
		 **/
		protected function switchTransitionComplete(event:PixelTransitionEvent):void
		{
			_switching = false;
		}
		
		/**
		 * 更新当前状态
		 * 
		 * 需要子类覆盖该方法加入自己的业务逻辑
		 * 
		 **/
		public function update():void
		{
			
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