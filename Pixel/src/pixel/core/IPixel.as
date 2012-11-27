package pixel.core
{
	import flash.events.IEventDispatcher;

	public interface IPixel extends IEventDispatcher
	{
		function update():void;
	}
}