package game.sdk.scene
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;

	public interface ISceneManager extends IEventDispatcher
	{
		function ChangeViewSize(Width:uint,Height:uint):void;
		function LoadScene(NavURL:String):void;
		function FindSceneByName(Name:String):ByteArray;
	}
}