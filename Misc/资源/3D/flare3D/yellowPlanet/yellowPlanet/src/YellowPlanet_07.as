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
	 * Jumping!
	 * 
	 * The concepts described in this section are similar to those used when developing any other Flash game. In this step, the goal is to make the astronaut jump over the Y axis.
     * Because the astronaut is located inside the container object, it doesn`t matter how the orientation of the container changes. The astronaut will always move up and down over its own Y axis.
     *
	 * After completing this step, you'll update the logic of the game. In order to manage the flow of the game play, it's important to add some state variables. Additionally, you'll add the function gameLogics to update all of the game states as the game is played.
	 */
	public class YellowPlanet_07 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		private var shadow:Pivot3D;
		private var sky:Pivot3D;
		
		private var smoke:Texture3D;
		private var fire:Texture3D;
		private var fireEmiter:FireEmiter;
		
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		private var collisions:SphereCollision;
		private var ray:RayCollision;
		
		// Working with the gameLogics method
		private var state:String = "run";
		private var jumpValue:Number = 0;
		
		public function YellowPlanet_07() 
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
			// Update the game logics.
			gameLogics();
			
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
			
			// Apply gravity.
			jumpValue -= 0.3;
			
			// Update the astronaut Y axis.
			astronaut.y += jumpValue;
			
			// Prevents to the astronaut to be under the floor.
			if ( astronaut.y < 0 ) 
			{
				astronaut.y = 0;
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
		
		private function gameLogics():void
		{
			switch( state )
			{
				case "run":
					
					if ( Input3D.keyHit( Input3D.SPACE ) ) 
					{
						jumpValue = 4;
						
						fireEmiter.emitParticlesPerFrame = 25;
						
						state = "jump";
						
						container.gotoAndPlay( "jump", 3 );
					}
					
				break;
				case "jump": 
				
					if ( astronaut.y == 0 )
					{
						state = "run";
						
						container.gotoAndPlay( "run", 3 );
					}
					
				break;
			}
		}
	}
}