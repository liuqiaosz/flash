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
	 * The astronaut movements and rays.
	 * 
	 * This step introduces a few new concepts.
	 * 
	 * First, explore how the game manages the user's input. Flare3D includes some utilities you can use to quickly manage the keyboard or mouse input as the game is played.
     * In this class, the Input3D.keyDown() method is used to detect which key is pressed. The method returns a true value while the key is held down.
     * The utility also includes the Input3D.keyHit() method, which is similar to keyDown but returns the true value only once.
     *
	 * The other cool thing present in this example is the use of rays.
	 * A ray is a virtual and infinite line that starts at some arbitrary point and continues infinitely in some direction.
	 * Rays can test if an object in the game intersects before reaching the infinite. If the test is true, the ray provides additional data about the collision, including the mesh, the exact point of the collision, the normal of the face that was collided, and other data.
     * Rays are used in this sample project because the astronaut needs to keep running on the spherical floor while remaining aligned to it. Rays are used to achieve both tasks.
     *
	 * 
	 * So, why use rays? the astronaut needs to keep on the spherical floor and also needs to be aligned to it. Rays can provide both.
	 * In this case, the stage is basically an sphere, so you can solve this using other methods, but rays also works with non uniform surfaces.
	 * 
	 * The steps to use the RayCollision are the folowing.
	 * 
	 * 1) Create a ray wing "new RayCollision()".
	 * 2) Add objects to test against that ray using "ray.addCollisionWith( object )".
	 * 3) Test a ray giving an starting point an direction using "ray.test( from, direction )".
	 * 4) Use the received data as you need.
	 * 
	 */
	public class YellowPlanet_04 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		private var shadow:Pivot3D;
		private var sky:Pivot3D;
		
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		// Declare the ray reference.
		private var ray:RayCollision;
		
		public function YellowPlanet_04() 
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
			
			// Creating a ray using the new RayCollision() method
			//Use the following line of code to create a new RayCollision:
			ray = new RayCollision();
			
			//Adding objects to test against that ray using the ray.addCollisionWith( object ) method
            //The following code adds the floor of the planet to test collisions with the ray:
            ray.addCollisionWith( planet.getChildByName( "floor" ), false ); 
            //The second argument ("false") indicates that the collision is detected only with the floor (discarding floor’s childs).

			
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
		}
		
		/**
		 * Rreset the level.
		 */
		private function startGame():void 
		{
			var startPoint:Pivot3D = planet.getChildByName( "start" );
			
			container.copyTransformFrom( startPoint );
			
			// Reset the camera position.
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 60, -20, container );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, container, container.getDir() );
		}
		
		private function updateEvent(e:Event):void 
		{
			if ( Input3D.keyDown( Input3D.UP ) ) container.translateZ( 1 );
			if ( Input3D.keyDown( Input3D.DOWN ) ) container.translateZ( -1 );
			if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
			if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
			
			// First, you need to take a point from where the ray will start, this should not be the exact astronaut position because that will be
			// so close to the floor that the ray will not intersect with anything, so take a point higher than that, lets say 
			// (0,100,0) and use localToGlobal to convert that point into the world coordinates.
			// Now that you have from where the ray needs to start, you need to give to it a direction, this direction should be pointing to the
			// down direction of the astronait, and you can get that vector using the getDown() method of Pivot3D.
			var from:Vector3D = container.localToGlobal( new Vector3D( 0, 100, 0 ) );
			var dir:Vector3D = container.getDown();
			
			// Testing a ray collision using the ray.test( from, direction ) method
			if ( ray.test( from, dir ) )
			{
			// Test the ray. if ( ray.test( from, dir ) ) { // Get the info of the first collision. var info:CollisionInfo = ray.data[0]; // Set the astronaut container at the collision point. container.setPosition( info.point.x, info.point.y, info.point.z ); // Align the astronaut container to the collision normal. container.setNormalOrientation( info.normal, 0.05 ); 
			}
			
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