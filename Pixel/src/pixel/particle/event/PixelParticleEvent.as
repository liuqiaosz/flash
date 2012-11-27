package pixel.particle.event
{
	import flash.events.Event;

	public class PixelParticleEvent extends Event
	{
		public static const PARTICLE_UPDATE:String = "ParticleUpdate";
		public static const PARTICLE_DEATH:String = "ParticleDeath";			//粒子生命耗尽
		public static const EMITTER_DEATH:String = "EmitterDeath";				//发射器生命周期耗尽
		
		public function PixelParticleEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}