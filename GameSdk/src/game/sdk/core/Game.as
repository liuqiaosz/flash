package game.sdk.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Game extends Sprite implements IGame
	{
		protected static var _GameApp:Game = null;
		
		protected var _Camera:Camera = null;
		public static function get GameApp():Game
		{
			return _GameApp;
		}
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE,OnAddedToStage);
			_GameApp = this;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			GameDirector.director.initialize(stage);
		}
		
		private function OnAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,OnAddedToStage);
			Initializer();
			addEventListener(Event.ENTER_FRAME,GameLoop);
			
		}
		
		protected function CameraSwitch(View:Camera):void
		{
			if(_Camera && contains(_Camera))
			{
				removeChild(_Camera);
			}
			_Camera = View;
			addChild(_Camera);
		}
		
		protected function GameLoop(event:Event):void
		{
			if(_Camera)
			{
				_Camera.Update();
			}
		}
		
		public function StartGame():void
		{
		}
		
		public function StopGame():void
		{
		}
		
		protected function Initializer():void
		{
			StartGame();
		}
	}
}
