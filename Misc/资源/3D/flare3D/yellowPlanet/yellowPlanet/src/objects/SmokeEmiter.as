package objects
{
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	
	public class SmokeEmiter extends ParticleEmiter3D 
	{
		public function SmokeEmiter( texture:Texture3D ) 
		{
			// Creates the material to use with the emiter particles.
			var material:Shader3D = new ParticleMaterial3D();
			material.filters.push( new TextureFilter( texture ) );
			material.filters.push( new ColorParticleFilter( [ 0xffffff, 0xffffff, 0xffffff], [ 0, 0.2, 0 ] ) );
			material.build();
			
			// Creates the emiter and pass to it the material and the particle template.
			super( "smoke", material, new SmokeParticle() );
			// The anount of particles to emit each frame.
			super.emitParticlesPerFrame = 2;
			// How much frames the particles life is.
			super.particlesLife = 20;
		}
	}
}

import flare.core.*;

class SmokeParticle extends Particle3D
{
	private var speed:Number;
	private var spin:Number;
	
	override public function init( emiter:ParticleEmiter3D ):void 
	{
		speed = Math.random() * 5;
		spin = 0.1;
		
		this.x = Math.random() * 20 - 10;
		this.y = Math.random() * 20 - 10;
		this.z = Math.random() * 20 - 10;
		
		var scale:Number = emiter.scaleX;
		
		this.sizeX = scale * 2;
		this.sizeY = scale * 2;
	}
	
	override public function update(time:Number):void 
	{
		this.y += speed;
		this.rotation += spin;
		this.sizeX *= 1.2;
		this.sizeY *= 1.2;
	}
	
	override public function clone():Particle3D 
	{
		return new SmokeParticle();
	}	
}