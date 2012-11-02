package game.sdk.core
{
	import flash.display.Stage;
	
	import game.sdk.scene.IScene;

	public interface IGameDirector
	{
		function initialize(stage:Stage):void;
		function switchScene(newScene:IScene):void;
		function pauseScene():void;
		function resumeScene():void;
	}
}