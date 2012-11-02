package
{
	import flare.core.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class FireParticle extends Particle3D
	{
		private var gravity:Number;
		private var velocity:Vector3D = new Vector3D();
		private var rotationVelocity:Number = 0;
		private var sizeVelocity:Number;
		
		override public function clone():Particle3D 
		{
			// return a new custom particle.
			// the ParticleEmiter3D will clone all particles he needs.
			return new FireParticle();
		}
		
		override public function init( emiter:ParticleEmiter3D ):void 
		{
			super.init( emiter );
			
			/* all particle initialization here. */
			
			super.x = Math.random() * 10.0 - 5.0;
			super.y = Math.random() * 10.0 - 5.0;
			super.z = Math.random() * 10.0 - 5.0;
			super.sizeX = 5;
			super.sizeY = 5;
			
			
			velocity.x = Math.random() * 1.0 - 0.5;
			velocity.y = Math.random() + 0.5;
			velocity.z = Math.random() * 1.0 - 0.5;
			
			if ( emiter.useGlobalSpace ) velocity = emiter.localToGlobalVector( velocity );
			
			velocity.scaleBy( 2 );
			
			rotationVelocity = Math.random() * 0.3 // - 2.5
			sizeVelocity = Math.random() * 0.1 + 0.15;
		}
		
		override public function update( time:Number ):void 
		{
			/* update the particle. */
			
			
			x += velocity.x;
			y += velocity.y;
			z += velocity.z;
			
			if ( y < 0 ) y = 0;
			
			sizeX += sizeVelocity;
			sizeY += sizeVelocity;
			rotation += rotationVelocity;
		}
	}
}