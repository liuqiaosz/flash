package death.def
{
	import com.greensock.TweenLite;
	
	import death.def.event.BleachDefenseEvent;
	import death.def.event.BleachMessage;
	import death.def.module.scene.IScene;
	
	import pixel.core.IPixelLayer;
	import pixel.core.PixelDirector;
	import pixel.core.PixelLauncher;
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessageBus;

	/**
	 * 场景控制枢纽
	 * 
	 * 
	 **/
	public class BleachDirector extends PixelDirector
	{
		public function BleachDirector()
		{
			super();
			addMessageListener(BleachMessage.BLEACH_SYNCSCENEDATA,showLoading);
			addMessageListener(BleachMessage.BLEACH_WORLD_REDIRECT,directWorld);
		}
		
		private function showLoading(msg:IPixelMessage):void
		{
			
		}
		private function directWorld(msg:IPixelMessage):void
		{
		}
		
		private var _newScene:IPixelLayer = null;
		
		/**
		 * 
		 * 场景切换重写
		 * 这里加入切换效果的支持
		 * 
		 **/
		override protected function swapScene(newScene:IPixelLayer):void
		{
			addScene(newScene);
			if(_activedScene)
			{
				_newScene = newScene;
				sceneMoveOut(_activedScene);
			}
			else
			{
				_activedScene = newScene;
				sceneMoveIn(_activedScene);
			}
		}
		
		/**
		 * 
		 * 场景滑入
		 * 
		 **/
		protected function sceneMoveIn(scene:IPixelLayer):void
		{
			scene.x = gameStage.stageWidth;
			scene.y = 0;
			scene.alpha = 0;
			TweenLite.to(_activedScene,2,{
				"x" : 0,
				"y" : 0,
				"alpha" : 1,
				onComplete : moveInComplete
			});
		}
		
		/**
		 * 
		 * 场景滑出
		 * 
		 **/
		protected function sceneMoveOut(scene:IPixelLayer):void
		{
			TweenLite.to(_activedScene,2,{
				"x" : -_activedScene.x,
				"y" : 0,
				"alpha" : 0,
				onComplete : moveOutComplete
			});
		}
		
		protected function moveOutComplete():void
		{
			_activedScene.x = 0;
			_activedScene.alpha = 1;
			_activedScene.visible = false;
			
			this.removeScene(_activedScene);
			if(_newScene)
			{
				_activedScene =_newScene;
				moveInComplete(_activedScene);
			}
		}
		
		protected function moveInComplete():void
		{
			_activedScene.reset();
		}
	}
}