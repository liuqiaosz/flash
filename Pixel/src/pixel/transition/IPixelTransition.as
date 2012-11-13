package pixel.transition
{
	import flash.events.IEventDispatcher;

	public interface IPixelTransition extends IEventDispatcher
	{
		function begin():void;
	}
}