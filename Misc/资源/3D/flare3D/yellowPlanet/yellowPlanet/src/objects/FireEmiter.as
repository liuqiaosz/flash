package objects
{
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	
	public class FireEmiter extends ParticleEmiter3D 
	{
		public function FireEmiter( texture:Texture3D ) 
		{
			// Creates the material to use with the emiter particles.
			var material:Shader3D = new ParticleMaterial3D();
			material.filters.push( new TextureFilter( texture ) );
			material.filters.push( new ColorParticleFilter( [ 0x033206, 0x033206 ], [ 1, 0 ] ) );
			material.build();
			
			// Creates the emiter and pass to it the material and the particle template.
			super( "fire", material, new FireParticle() );
			// Lets to the particles to use global coordinates instead to be linked to the emiter.
			super.useGlobalSpace = true;
			// The anount of particles to emit each frame.
			super.emitParticlesPerFrame = 25;
			// How much frames the particles life is.
			super.particlesLife = 50;
			// this enable the shot particles mode.
			// a value of 0 (by default), keeps the emision constantly as the first case.
			// if the value is -1, the emitParticlesPerFrame property will be seted to 0 after fire
			// the particles and no particles will be fired after a new emitParticlesPerFrame value is defined. 
			// a different value (1 to n), will decrement the amount of particles to fire by decrementPerFrame value.
			// if we set a emitParticlesPerFrame to a value of 10, and decrementPerFrame to 2, the first frame will fire 10,
			// the second 8, the third 6, etc...until emitParticlesPerFrame is equal to 0.
			super.decrementPerFrame = 1;
			// Moves the emiter to adjust the position.
			super.y = 4;
		}
	}
}

import flare.core.*;
import flash.geom.*;

class FireParticle extends Particle3D
{
	private var spin:Number;
	private var velocity:Vector3D = new Vector3D();
	
	override public function init( emiter:ParticleEmiter3D ):void 
	{
		spin = 0.1;
		
		velocity.x = Math.random() * 0.2 - 0.1;
		velocity.z = Math.random() * 0.2 - 0.1;
		
		// If the emiter use global space, transform the velocity to the emiter coordinates.
		if ( emiter.useGlobalSpace ) velocity = emiter.localToGlobalVector( velocity );		
		
		this.x = Math.random() * 1 - 0.5;
		this.y = Math.random() * 1 - 0.5;
		this.z = Math.random() * 1 - 0.5;
		
		var scale:Number = 0.5;
		
		this.sizeX = scale;
		this.sizeY = scale;
	}
	
	override public function update(time:Number):void 
	{
		this.x += velocity.x;
		this.z += velocity.z;
		this.sizeX *= 0.85;
		this.sizeY *= 0.85;
	}
	
	override public function clone():Particle3D 
	{
		return new FireParticle();
	}	
}