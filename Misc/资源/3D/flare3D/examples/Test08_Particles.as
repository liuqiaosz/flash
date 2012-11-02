package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import particles.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Particle effects.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test08_Particles extends Base 
	{
		private var scene:Scene3D;
		private var texture:Texture3D;
		private var reflection:Texture3D;
		private var cone:Cone;
		private var emiter:ParticleEmiter3D;
		private var clone:ParticleEmiter3D;
		
		public function Test08_Particles() 
		{
			super( "Particles - Drag to rotate the camera.\n" +
				   "Press 'A' to fire new particles and SPACE to switch between global and local space." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Viewer3D( this );
			scene.camera = new Camera3D();
			scene.camera.setPosition( 0, 200, -400 );
			scene.camera.lookAt( 0, 0, 0 );
			
			// loads an external Texture3D.
			texture = scene.addTextureFromFile( "../resources/Cross_0005.jpg" );
			reflection = scene.addTextureFromFile( "../resources/reflections.jpg" );
			
			var material:ParticleMaterial3D = new ParticleMaterial3D();
			material.filters.push( new TextureFilter( texture ) );
			material.filters.push( new ColorParticleFilter( [ 0xffff00, 0xff0000, 0x00ff00, 0x0000ff ], [1, 1, 1, 0] ) );
			material.build();
			
			// creates the emiter.
			emiter = new ParticleEmiter3D( "emiter", material, new CustomParticle() );
			emiter.useGlobalSpace = true;
			emiter.particlesLife = 50;
			emiter.emitParticlesPerFrame = 10;
			emiter.parent = cone;
			// particles and objects with alpha, usually need to be render
			// after the other 3d objects to prevent z-buffer issues.
			emiter.layer = 10;
			
			cone = new Cone();
			cone.addChild( emiter );
			scene.addChild( cone );
			
			// creates another particles material.
			var material2:ParticleMaterial3D = new ParticleMaterial3D()
			material2.filters.push( new TextureFilter( texture ) )
			material2.filters.push( new PlanarFilter( reflection, 200 ) );
			material2.filters.push( new ColorParticleFilter( [ 0xffffff, 0x0000ff ], [1, 0], [ 128, 255 ] ) );
			material2.build();
			
			// creates a clone of the original emiter.
			clone = emiter.clone() as ParticleEmiter3D;
			clone.material = material2;
			// this enable the shot particles mode.
			// a value of 0 (by default), keeps the emision constantly as the first case.
			// if the value is -1, the emitParticlesPerFrame property will be seted to 0 after fire
			// the particles and no particles will be fired after a new emitParticlesPerFrame value is defined. 
			// a different value (1 to n), will decrement the amount of particles to fire by decrementPerFrame value.
			// if we set a emitParticlesPerFrame to a value of 10, and decrementPerFrame to 2, the first frame will fire 10,
			// the second 8, the third 6, etc...until emitParticlesPerFrame is equal to 0.
			clone.decrementPerFrame = -1;
			
			var cube:Cube = new Cube();
			cube.addChild( clone );
			scene.addChild( cube );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			cone.x = Math.cos( getTimer() / 1000 ) * 150;
			cone.z = Math.sin( getTimer() / 1000 ) * 150;
			cone.y = 100
			
			cone.rotateX(1.5);
			cone.rotateY(1.7);
			cone.rotateZ(1.3);
			
			// fire 100 particles only once.
			if ( Input3D.keyHit( Input3D.A ) ) clone.emitParticlesPerFrame = 100;
			
			// change the space of the particles.
			if ( Input3D.keyHit( Input3D.SPACE ) ) emiter.useGlobalSpace = !emiter.useGlobalSpace;
			
			if ( !Input3D.mouseDown )
			{
				scene.camera.rotateY( 0.1, false, Vector3DUtils.ZERO );
			}
		}
	}
}