package particles
{
	import flare.core.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class CustomParticle2 extends Particle3D
	{
		private var gravity:Number;
		private var velocity:Vector3D = new Vector3D();
		private var rotationVelocity:Number = 0;
		private var sizeVelocity:Number;
		
		public function CustomParticle2() 
		{
		}
		
		override public function clone():Particle3D 
		{
			// return a new custom particle.
			// the ParticleEmiter3D will clone all particles he needs.
			return new CustomParticle2();
		}
		
		override public function init( emiter:ParticleEmiter3D ):void 
		{
			super.init( emiter );
			
			/* all particle initialization here. */
			
			super.x = 0;
			super.y = 0;
			super.z = 0;
			super.sizeX = 1;
			super.sizeY = 1;
			
			gravity = 0;
			velocity.x = Math.random() * 1.0 - 0.5;
			velocity.y = Math.random() * 2.0 //+ 2.0;
			velocity.z = Math.random() * 1.0 - 0.5;
			
			if ( emiter.useGlobalSpace ) velocity = emiter.localToGlobalVector( velocity );
			
			velocity.scaleBy( 8 );
			
			rotationVelocity = Math.random() * 0.3 // - 2.5
			sizeVelocity = Math.random() * 0.2 + 0.3;
		}
		
		override public function update( time:Number ):void 
		{
			/* update the particle. */
			
			gravity -= 0.5;
			x += velocity.x;
			y += velocity.y + gravity;
			z += velocity.z;
			
			sizeX += sizeVelocity;
			sizeY += sizeVelocity;
			rotation += rotationVelocity;
		}
	}
}