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
	 * Interacting with the word.
	 * 
	 * It's time to kill enemys, die, fly!
	 * 
	 * Just a few things to bring the game to the life, as the previous step, 
	 * this part continues with the game logics.
	 * Also the fan and mines behaviors will be moved to a new function called gameObjects.
	 */
	public class YellowPlanet_08 extends Sprite 
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
		
		// Create a new game variable in the game logic variables named shakeFactor:
		private var state:String = "run";
		private var jumpValue:Number = 0;
		private var shakeFactor:Number;
		
		public function YellowPlanet_08() 
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
			if ( astronaut.y < 0 ) astronaut.y = 0;
			
			// Update all game objects.
			gameObjects();
			
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 80, -20, astronaut, 0.1 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, astronaut, container.getDir(), 0.05 );
			
			if ( shakeFactor > 0 )
			{
				scene.camera.x += Math.random() * shakeFactor;
				scene.camera.y += Math.random() * shakeFactor;
				scene.camera.z += Math.random() * shakeFactor;
				shakeFactor *= 0.9;
			}
		}
		
		private function gameLogics():void
		{
			switch( state )
			{
				case "run":
					
					if ( Input3D.keyDown( Input3D.UP ) ) container.translateZ( 1 );
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					if ( Input3D.keyHit( Input3D.SPACE ) ) 
					{
						jumpValue = 4;
						
						fireEmiter.emitParticlesPerFrame = 25;
						
						state = "jump";
						
						container.gotoAndPlay( "jump", 3 );
					}
					
				break;
				case "jump": 
				
					if ( Input3D.keyDown( Input3D.UP ) ) container.translateZ( 1 );
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					if ( astronaut.y == 0 )
					{
						state = "run";
						
						container.gotoAndPlay( "run", 3 );
					}
					
				break;
				case "fan":
					
					// Lets astronaut to jump to the sky...
					jumpValue = 4;
					fireEmiter.emitParticlesPerFrame = 25;
					container.rotateY(1);
					shakeFactor = 1;
					
				break;
			}
		}
		
		private function gameObjects():void
		{
			// Gets the global position of the astronaut.
			var position:Vector3D = astronaut.getPosition(false);
			
			for each ( var f:Pivot3D in fan )
			{
				f.rotateY( f.userData.speed );
				
				// The original fan radius is around 15 units, but some of them 
				// are scaled to fit the holes, so you need to scale the radius proportionally.
				var radius:Number = f.scaleX * 15;
				
				// If the distance between the astronaut and fan is less than the fan radius,
				// changes the state to "fan"
				if ( Vector3D.distance( f.getPosition(), position ) < radius ) state = "fan";
			}
			
			for each ( var m:Pivot3D in mines )
			{
				m.rotateY( m.userData.speed );
				m.userData.frequency += 0.1
				m.translateY( Math.cos( m.userData.frequency ) * 0.1 );
				
				// Similar as the fan, but the mines could be visible/invisible and they are not scaled.
				if ( m.visible && Vector3D.distance( m.getPosition(), position ) < 10 )
				{
					if ( state == "jump" )
					{
						// If the astronaut is jumping, kill the mine.
						m.visible = false;
						shakeFactor = 2;
					}
					else if ( state == "run" )
					{
						// It the astronaut was running, it will die! :(
						container.visible = false;
						shakeFactor = 15;
						state = "die";
					}
				}
				
				
				if ( m.visible == false ) 
				{
					// If the mine was killed, and it is in the other side of the planet, git it to the life again.
					// When you multiplies two vectors using dotProduct, and both are pointing to the same direction,
					// This line gets the mine Up vector var mineUp:Vector3D = m.getUp(); //This line gets astronaut Up vector var contUp:Vector3D = container.getUp(); //Here compare the vector and re-activate the mine if result is great than zero. if ( mineUp.dotProduct( contUp ) < 0 ) m.visible = true; 
				}
			}
			
			sky.rotateX(0.1);
		}
	}
}