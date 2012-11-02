package game.sdk.core
{
	import flash.sensors.Accelerometer;

	public class GameDirector
	{
		private static var _instance:IGameDirector = null;
		
		public function GameDirector()
		{
		}
		
		public static function get director():IGameDirector
		{
			if(_instance ==  null)
			{
				_instance = new GameDirectorImpl();
			}
			
			return _instance;
		}
	}
}
import flash.display.Stage;

import game.sdk.core.IGameDirector;
import game.sdk.scene.IScene;

class GameDirectorImpl implements IGameDirector
{
	private var _gameStage:Stage = null;
	private var _initialized:Boolean = false;
	private var _currentScene:IScene = null;
	
	public function switchScene(newScene:IScene):void
	{
	}
	public function pauseScene():void
	{
	}
	public function resumeScene():void
	{
	}
	
	public function initialize(stage:Stage):void
	{
		if(!_initialized)
		{
			_gameStage = stage;
			_initialized = true;
		}
	}
}