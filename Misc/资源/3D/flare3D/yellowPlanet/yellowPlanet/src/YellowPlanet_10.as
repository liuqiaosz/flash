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
	 * Adding energy items, speed and final gameplay adjustments!!
	 */
	public class YellowPlanet_10 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		private var shadow:Pivot3D;
		private var sky:Pivot3D;
		private var energy:Pivot3D;
		
		private var smoke:Texture3D;
		private var fire:Texture3D;
		private var fireEmiter:FireEmiter;
		
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var points:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		private var collisions:SphereCollision;
		private var ray:RayCollision;
		
		// Game new logics variables.
		private var state:String = "run";
		private var jumpValue:Number = 0;
		private var speed:Number;
		private var speedCounter:Number;
		private var score:int;
		private var bestScore:int;
		private var energyCount:int;
		private var energyIndex:int;
		private var shakeFactor:Number;
		private var resetCounter:int;
		
		// MovieClip and Sound objects.
		private var loading:Loading = new Loading();
		private var gui:GUI = new GUI();
		private var sndMusic:MusicSound = new MusicSound();
		private var sndCoin:CoinSound = new CoinSound();
		private var sndDead:DeadSound = new DeadSound();
		private var sndFan:FanSound = new FanSound();
		private var sndJump:JumpSound = new JumpSound();
		private var sndMine:MineSound = new MineSound();
		private var sndStart:StartSound = new StartSound();
		private var sndReset:ResetSound = new ResetSound();
		private var sndScore:ScoreSound = new ScoreSound();
		
		public function YellowPlanet_10() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Adds the MovieClips to the stage.
			addChild( gui );
			addChild( loading );
			
			scene = new Scene3D(this);
			scene.antialias = 2;
			scene.camera = new Camera3D();
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.pause();
			
			planet = scene.addChildFromFile( "planet.f3d" );
			astronaut = scene.addChildFromFile( "astronaut.f3d" );
			shadow = scene.addChildFromFile( "shadow.f3d" );
			energy = scene.addChildFromFile( "energy.f3d" );
			smoke = scene.addTextureFromFile( "smoke.png" );
			fire = scene.addTextureFromFile( "particle.png" );
			
			sndMusic.play( 0, 999999 );
		}
		
		private function progressEvent(e:Event):void 
		{
			// Updates the loading bar.
			loading.bar.gotoAndStop( int(scene.loadProgress) );
		}
		
		private function completeEvent(e:Event):void 
		{
			// Once the scene is loaded, remove the loading MovieClip.
			removeChild( loading );
			
			gui.total.visible = false;
			
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
			else if ( pivot.name == "point" )
			{
				points.push( pivot );
			}
		}
		
		/**
		 * Rreset the level.
		 */
		private function startGame():void 
		{
			var startPoint:Pivot3D = planet.getChildByName( "start" );
			
			// Some changes here.
			container.copyTransformFrom( startPoint );
			container.gotoAndStop(0);
			container.visible = true;
			
			// Reset some values.
			gui.spacebar.visible = true;
			gui.speed.visible = false;
			state = "start";
			speed = 0.85;
			speedCounter = 1;
			jumpValue = 0;
			energyCount = 0;
			astronaut.y = 0;
			shakeFactor = 0;
			
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
				container.setNormalOrientation( info.normal, 0.1 );
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
			
			// Updates the interface of the game.
			gameGUI();
		}
		
		private function gameLogics():void
		{
			switch( state )
			{
				case "start":
					
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					if ( Input3D.keyHit( Input3D.SPACE ) )
					{
						state = "run";
						container.gotoAndPlay( "run" );
						fireEmiter.emitParticlesPerFrame = 25;
						gui.controls.visible = false;
						gui.spacebar.visible = false;
						gui.total.visible = false;
						score = 0;
						jumpValue = 3;
						sndCoin.play();
					}
					
				break;
				case "run":
					
					container.translateZ( speed );
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					if ( Input3D.keyHit( Input3D.SPACE ) ) 
					{
						jumpValue = 4;
						sndJump.play();
						
						fireEmiter.emitParticlesPerFrame = 25;
						
						state = "jump";
						
						container.gotoAndPlay( "jump", 3 );
					}
					
					if ( speed > 1 ) fireEmiter.emitParticlesPerFrame = 25;
					
				break;
				case "jump": 
					
					container.translateZ( speed );
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					if ( astronaut.y == 0 )
					{
						state = "run";
						
						container.gotoAndPlay( "run", 3 );
					}
					
				break;
				case "fan":
					
					jumpValue = 3;
					fireEmiter.emitParticlesPerFrame = 25;
					container.rotateY(1);
					shakeFactor = 1;
					gui.total.visible = true;
					if ( astronaut.y > 500 ) startGame();
					
				break;
				case "die":
					
					gui.total.visible = true;
					resetCounter--;
					if ( resetCounter < 0 ) startGame();
					
				break;
				case "energy":
				
					if ( Input3D.keyDown( Input3D.RIGHT ) ) container.rotateY( 5 );
					if ( Input3D.keyDown( Input3D.LEFT ) ) container.rotateY( -5 );
					resetCounter--;
					if ( resetCounter < 0 ) state = "run";
				
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
				if ( Vector3D.distance( f.getPosition(), position ) < radius ) 
				{
					state = "fan";
					sndFan.play();
				}
			}
			
			for each ( var m:Pivot3D in mines )
			{
				m.rotateY( m.userData.speed );
				m.userData.frequency += 0.1
				m.translateY( Math.cos( m.userData.frequency ) * 0.1 );
				
				if ( m.visible && Vector3D.distance( m.getPosition(), position ) < 10 )
				{
					if ( state == "jump" )
					{
						m.visible = false;
						score += 100;
						shakeFactor = 2;
						sndMine.play();
						newPop();
					}
					else if ( state == "run" )
					{
						container.visible = false;
						state = "die";
						resetCounter = 100;
						shakeFactor = 15;
						sndDead.play();
						newCrash();
					}
				}
				
				if ( m.visible == false ) 
				{
					var mineUp:Vector3D = m.getUp();
					var contUp:Vector3D = container.getUp();
					if ( mineUp.dotProduct( contUp ) < 0 ) m.visible = true;
				}
			}
			
			energy.copyTransformFrom( points[energyIndex] );
			
			if ( Vector3D.distance( energy.getPosition(), position ) < 10 )
			{
				// Pick a random position.
				var currIndex:int = energyIndex;
				while ( currIndex == energyIndex ) energyIndex = Math.random() * points.length;
				score += 300;
				energyCount++;
				if ( energyCount == 3 )
				{
					speedCounter++;
					speed += 0.2;
					gui.speed.visible = true;
					gui.speed.content.value.text = speedCounter.toString();
					gui.speed.gotoAndPlay(1);
					energyCount = 0;
					resetCounter = 120;
					state = "energy";
				}
				newPower();
				sndReset.play();
			}
			
			sky.rotateX(0.1);
		}
		
		private function gameGUI():void 
		{
			// Gets the best score.
			if ( score > bestScore ) bestScore = score;
			
			gui.points.score.text = score.toString();
			gui.best.score.text = bestScore.toString();
			gui.energy.content.count.text = energyCount.toString();
			gui.total.score.text = score.toString();
		}
		
		private function newPop():void
		{
			var pos:Vector3D = container.getScreenCoords();
			var pop:Pop = new Pop();
			pop.x = pos.x;
			pop.y = pos.y;
			addChild( pop );
		}
		
		private function newCrash():void
		{
			var pos:Vector3D = container.getScreenCoords();
			var crash:Crash = new Crash();
			crash.x = pos.x;
			crash.y = pos.y;
			addChild( crash );
		}
		
		private function newPower():void
		{
			var pos:Vector3D = container.getScreenCoords();
			var power:Power = new Power();
			power.x = pos.x;
			power.y = pos.y;
			addChild( power );
		}
	}
}