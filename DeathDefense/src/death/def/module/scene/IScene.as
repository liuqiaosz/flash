package death.def.module.scene
{
	import flash.events.IEventDispatcher;

	public interface IScene extends IEventDispatcher
	{
		function pause():void;
		function resume():void;
	}
}