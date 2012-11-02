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
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Detecting collisions with obstacles 
	 * 
	 * What is the SphereCollision? 
	 * The SphereCollision is a utility that works with complex geometry collisions. It is basically a virtual sphere that collides and reacts with one or many mesh objects (see Figure 10).
	 * 
	 * Figure 10. The SphereCollision crashes into mesh objects in the game. 
	 * This sample game uses SphereCollisions to enable the astronaut to collide with the walls and obstacles around the planet. Using SphereCollision, you can wrap the astronaut in virtual sphere to collide with the game environment.
	 * The SphereCollision utility also provides a smooth displacement when the collision ocours, which is called a slider.
	 * 
	 * The following steps illustrate how to use the SphereCollision class:
	 * 
	 * 1) Create an SphereCollision instance, You need to pass to it a target for the sphere and a radious.
	 * 2) Add objects to test against that sphere using the collisions.addCollisionWith( object ) method.
	 * 3) Update the collisions by calling the collisions.slider(), collisions.fixed() or collisions.intersect() methods.
	 * 4) If a collision occurs, you can access and use the collision data as needed
	 * 
	 * Note: RayCollision and SphereCollision are intensive math algorithms, so it's best to use them with low polygonal objects when possible. Since these utilities perform such complex mathematical equations, you'll notice a significant performance difference when running the project in debug or release mode. Additionally, SphereCollision does not work with scaled objects, so always normalize your collision objects before working with them in the game.
	 */
	public class YellowPlanet_05 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		private var shadow:Pivot3D;
		private var sky:Pivot3D;
		
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		// The instance for the SphereCollision.
		private var collisions:SphereCollision;
		
		private var ray:RayCollision;
		
		public function YellowPlanet_05() 
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
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			sky = planet.getChildByName( "sky" );
			
			container = new Pivot3D();
			container.addChild( astronaut );
			container.addChild( shadow );
			scene.addChild( container );
			
			ray = new RayCollision();
			ray.addCollisionWith( planet.getChildByName( "floor" ), false );
			
			// Creating sphere collisions using the SphereCollision (source, radius, offset) method
			// By default, the virtual sphere will be positioned at the center of the pivot. In this example, the pivot of the astronaut is at his feet, so you need to apply an offset for the virtual sphere, which is the third Vector3D parameter at (0,3,0) as shown in Figure 12.
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
				// If the object is an obstacle, add it to the collisions list.
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
			
			// Because SphereCollision test also for intersections, you need to reset the
			// collision when you reset the astronaut position too.
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
			
			// Once you moved the astronait, test for collisions. If it is colliding with something, this method
			// will produce a displacement to fix the intersection and put the astronaut on the right place.
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
			
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 80, -20, container, 0.1 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, container, container.getDir(), 0.05 );
		}
	}
}