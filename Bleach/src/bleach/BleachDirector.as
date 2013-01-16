package bleach
{
	import bleach.event.BleachDefenseEvent;
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.module.loader.MaskLoading;
	import bleach.module.scene.IScene;
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	import pixel.core.IPixelDirector;
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
	public class BleachDirector extends PixelDirector implements IPixelDirector
	{
		private var _loading:Boolean = false;
		private var _topLayer:Sprite = null;
		private var _contentLayer:Sprite = null;
		public function BleachDirector()
		{
			super();
			
			
//			_contentLayer = new Sprite();
//			_topLayer = new Sprite();
//			gameStage.addChild(_contentLayer);
//			gameStage.addChild(_topLayer);
		}
		
		override public function initializer():void
		{
			super.initializer();
			addMessageListener(BleachMessage.BLEACH_WORLD_REDIRECT,directWorld);
			
			//Loading消息监听
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_SHOW,loadingShow);
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_HIDE,loadingHide);
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_UPDATE,loadingUpdate);
		}
		
		private function loadingShow(msg:BleachLoadingMessage):void
		{
			addSceneTop(MaskLoading.instance);
			_loading = true;
		}
		
		private function loadingHide(msg:BleachLoadingMessage):void
		{
			TweenLite.to(MaskLoading.instance,0.5,{
				"alpha" : 0,
				onComplete : hideComplete
			});
		}
		
		private function hideComplete():void
		{
			removeSceneTop(MaskLoading.instance);
			MaskLoading.instance.alpha = 1;
			_loading = false;
		}
		
		private function loadingUpdate(msg:BleachLoadingMessage):void
		{
			if(_loading)
			{
				MaskLoading.instance.progressUpdate(msg.total,msg.loaded);
			}
		}
		
		private function directWorld(msg:IPixelMessage):void
		{
			var scene:Object = msg.value;
			
			if(scene)
			{
				this.switchScene(scene as Class);
			}
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
				sceneFadeOut(_activedScene);
				this.removeScene(_activedScene);
			}
			else
			{
				_activedScene = newScene;
				sceneFadeIn(_activedScene);
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
			TweenLite.to(_activedScene,1,{
				"x" : -_activedScene.x,
				"y" : 0,
				"alpha" : 0,
				onComplete : moveOutComplete
			});
		}
		
		protected function sceneFadeIn(scene:IPixelLayer):void
		{
			_activedScene.alpha = 0;
			TweenLite.to(_activedScene,1,{
				"alpha" : 1
			});
		}
		
		protected function sceneFadeOut(scene:IPixelLayer):void
		{
			_activedScene.alpha = 1;
			TweenLite.to(_activedScene,0.5,{
				"alpha" : 0
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
				//moveInComplete(_activedScene);
				moveInComplete();
			}
		}
		
		protected function moveInComplete():void
		{
			_activedScene.reset();
		}
	}
}