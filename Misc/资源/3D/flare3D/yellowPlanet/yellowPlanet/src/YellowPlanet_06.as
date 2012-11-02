package  
{
	import flare.basic.*;
	import flare.collisions.*;
	import flare.core.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import objects.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Adding particle effects to simulate fire and smoke.
	 * 
	 * So, it's time to add some nice looking effects!
	 * 
	 * Why particles are special?
	 * 
	 * Particles enable you to quickly draw a large set of data simultaneously. When you create effects, you can group all of the particles and draw them together in one draw call, to avoid drawing each particle separately. As you can imagine, this strategy increases the drawing speed, because particles works a bit differently than other 3D objects and they are usually facing the camera.
	 * 
	 * Follow these steps to use particles in a 3D Flash game:
	 * 
	 * 1. Create a particle class that extends the Particle3D class to use as a particle template.
     * 2. Override the methods init, update and clone from the Particle3D class to add the desired behavior to the particles.
     * 3. Create a ParticleMaterial3D class to set textures, colors or any other filter compatible with particles.
     * 4. Create a ParticleEmiter3D class using the material and particle template.
     * 5. Configure the emitter using the emitParticlesPerFrame, particlesLife and decrementPerFrame properties.

	 * 
	 * In this example, the new emitters were created in separate classes that extend from the ParticleEmiter3D class to keep the code simple and easier to update.
	 */
	public class YellowPlanet_06 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		private var shadow:Pivot3D;
		private var sky:Pivot3D;
		
		// Variables used for particles.
		private var smoke:Texture3D;
		private var fire:Texture3D;
		private var fireEmiter:FireEmiter;
		
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		private var collisions:SphereCollision;
		private var ray:RayCollision;
		
		public function YellowPlanet_06() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Scene3D(this);
			scene.antialias = 2;
			scene.camera = new Camera3D();
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.pause();
			
			planet = scene.addChildFromFile( "planet.f3d" );
			astronaut = scene.addChildFromFile( "astronaut.f3d" );
			shadow = scene.addChildFromFile( "shadow.f3d" );
			
			// Textures used for particle emiters.
			smoke = scene.addTextureFromFile( "smoke.png" );
			fire = scene.addTextureFromFile( "particle.png" );
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			sky = planet.getChildByName( "sky" );
			
			// Creates the fire emiter and adds it to the astronaut.
			fireEmiter = new FireEmiter( fire );
			fireEmiter.parent = astronaut;
			
			container = new Pivot3D();
			container.addChild( astronaut );
			container.addChild( shadow );
			scene.addChild( container );
			
			ray = new RayCollision();
			ray.addCollisionWith( planet.getChildByName( "floor" ), false );
			
			collisions = new SphereCollision( container, 3, new Vector3D( 0, 3, 0 ) );
			
			planet.forEach( setupScene );
			
			startGame();
			
			scene.resume();
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		/**
		 * Goes through all objects and adds the important to different Vectors.
		 */
		private function setupScene( pivot:Pivot3D ):void 
		{
			if ( pivot.name == "fan" ) 
			{
				pivot.userData = new Object();
				pivot.userData.speed = Math.random() * 5 + 5;
				fan.push( pivot );
				
				// Creates a new smoke emiter and them to the scene.
				var particles:SmokeEmiter = new SmokeEmiter( smoke );
				particles.copyTransformFrom( pivot );
				particles.parent = scene;
			}
			else if ( pivot.name == "mine" )
			{
				pivot.userData = new Object();
				pivot.userData.speed = Math.random() * -10 - 10;
				pivot.userData.frequency = Math.random() * 500 + 500;
				mines.push( pivot );
			}
			else if ( pivot.name == "obstacle" )
			{
				collisions.addCollisionWith( pivot, false );
			}
		}
		
		/**
		 * Rreset the level.
		 */
		private function startGame():void 
		{
			var startPoint:Pivot3D = planet.getChildByName( "start" );
			
			container.copyTransformFrom( startPoint );
			container.gotoAndPlay( "run" );
			
			collisions.reset();
			
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 60, -20, container );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, container, container.getDir() );
		}
		
		private function updateEvent(e:Event):void 
		{
			if ( Input3D.keyDown( Input3D.UP ) ) container.translateZ( 1 );
			if ( Input3D.keyDown( Input3D.DOWN ) ) container.translateZ( -1 );
			if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
			if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
			
			var from:Vector3D = container.localToGlobal( new Vector3D( 0, 100, 0 ) );
			var dir:Vector3D = container.getDown();
			
			if ( ray.test( from, dir ) )
			{
				var info:CollisionInfo = ray.data[0];
				container.setPosition( info.point.x, info.point.y, info.point.z );
				container.setNormalOrientation( info.normal, 0.05 );
			}
			
			collisions.slider();
			
			for each ( var f:Pivot3D in fan )
			{
				f.rotateY( f.userData.speed );
			}
			
			for each ( var m:Pivot3D in mines )
			{
				m.rotateY( m.userData.speed );
				m.userData.frequency += 0.1
				m.translateY( Math.cos( m.userData.frequency ) * 0.1 );
			}
			
			sky.rotateX(0.1);
			
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 220, -20, container, 0.1 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, container, container.getDir(), 0.05 );
		}
	}
}