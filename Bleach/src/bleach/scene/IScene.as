package bleach.scene
{
	import flash.events.IEventDispatcher;
	
	import pixel.utility.IDispose;

	public interface IScene extends IEventDispatcher,IDispose
	{
		function unactived():void;
		function actived():void;
//		function dealloc():void;
	}
}