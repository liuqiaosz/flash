package bleach.scene
{
	import flash.events.IEventDispatcher;

	public interface IScene extends IEventDispatcher
	{
		function unactived():void;
		function actived():void;
		function dealloc():void;
	}
}