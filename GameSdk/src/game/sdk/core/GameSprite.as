package game.sdk.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class GameSprite extends Sprite implements IRender
	{
		//当前舞台
		protected var _GameStage:Stage = null;
		
		protected var _Update:Boolean = false;
		public function GameSprite()
		{
			addEventListener(Event.ADDED_TO_STAGE,OnStageReady);
		}
		
		/**
		 * 添加至显示舞台
		 **/
		protected function OnStageReady(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,OnStageReady);
			_GameStage = stage;
			_GameStage.addEventListener(Event.RENDER,StageRender);
			
			if(_Update)
			{
				_GameStage.invalidate();
			}
			
		}
		
		public function Update():void
		{
			_Update = true;
			if(_GameStage)
			{
				_GameStage.invalidate();
			}
		}
		
		/**
		 * 渲染
		 **/
		protected function StageRender(event:Event):void
		{
			if(_Update)
			{
				_Update = false;
				Render();
			}
		}
		
		
		public function Render():void
		{
		}
	}
}