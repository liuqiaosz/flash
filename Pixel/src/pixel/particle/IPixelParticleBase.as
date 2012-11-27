package pixel.particle
{
	import flash.events.IEventDispatcher;

	public interface IPixelParticleBase extends IEventDispatcher
	{
		function reset():void;
		function update():void;
		
	}
}