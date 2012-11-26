package pixel.particle.event
{
	import flash.events.Event;

	public class PixelParticleEvent extends Event
	{
		public static const PARTICLE_UPDATE:String = "ParticleUpdate";
		public function PixelParticleEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}