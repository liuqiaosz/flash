package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Giving life to the world.
	 */
	public class YellowPlanet_02 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		
		private var sky:Pivot3D;
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		public function YellowPlanet_02() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Viewer3D(this);
			scene.antialias = 2;
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// This prevents to the scene to start rendering.
			// Otherwise, the objects wlil start showing while loading.
			scene.pause();
			
			planet = scene.addChildFromFile( "planet.f3d" );
			astronaut = scene.addChildFromFile( "astronaut.f3d" );
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			// Once the scene is loaded, all the objects are accessibles.
			trace( "load complete!" );
			
			// This asks for the mesh named sky inside the planet model.
			// This method goes recursively in the hierarchy until it finds the requested object.
			// If nothing was found, returns null.
			sky = planet.getChildByName( "sky" );
			
			// The forEach method, calls a function for each of the childrens of the planet.
			planet.forEach( setupScene );
			
			// Starts the level.
			startGame();
			
			// Continues rendering the scene.
			scene.resume();
			
			// Starts to update the game. This is very similar to the enterFrame event, but it is based
			// on time to ensure that the game runs always at the same speed
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		/**
		 * Goes through all objects.
		 */
		private function setupScene( pivot:Pivot3D ):void 
		{
			if ( pivot.name == "fan" ) 
			{
				// All Pivot3D objects has a userData property you can use to store your own data.
				pivot.userData = new Object();
				pivot.userData.speed = Math.random() * 5 + 5;
				// Adds to fan Vector.
				fan.push( pivot );
			}
			else if ( pivot.name == "mine" )
			{
				pivot.userData = new Object();
				pivot.userData.speed = Math.random() * -10 - 10;
				pivot.userData.frequency = Math.random() * 500 + 500;
				// Adds to mines Vector.
				mines.push( pivot );
			}
		}
		
		/**
		 * Resset the level.
		 */
		private function startGame():void 
		{
			// This is an empty reference point (Helper) on the planet model.
			var startPoint:Pivot3D = planet.getChildByName( "start" );
			
			// Copy the position and orientation to the astronaut.
			astronaut.copyTransformFrom( startPoint );
		}
		
		/**
		 * This is the main loop of the game, here you need to update all the things.
		 */
		private function updateEvent(e:Event):void 
		{
			// Update the world.
			
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
		}
	}
}