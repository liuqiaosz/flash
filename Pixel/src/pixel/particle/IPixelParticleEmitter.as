package pixel.particle
{
	public interface IPixelParticleEmitter extends IPixelParticleBase
	{
		function start():void;
		function pause():void;
		function stop():void;
	}
}