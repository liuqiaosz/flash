package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * The camera and astronaut container.
	 */
	public class YellowPlanet_03 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		private var container:Pivot3D;
		
		private var sky:Pivot3D;
		private var mines:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		private var fan:Vector.<Pivot3D> = new Vector.<Pivot3D>();
		
		public function YellowPlanet_03() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// In this step, go back to the Scene3D to get full control over the camera.
			scene = new Scene3D(this);
			scene.antialias = 2;
			
			// Creates your own camera.
			scene.camera = new Camera3D();
			
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
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
			sky = planet.getChildByName( "sky" );
			
			// The next steps will require more control over the astronaut.
			// This creates an empty 3D container and adds the astronaut to it.
			container = new Pivot3D();
			container.addChild( astronaut );
			
			// Adds the container to the scene too, otherwise the objects will not be present on the scene.
			scene.addChild( container );
			
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
			
			// Now that the container for the astronait was created, use it to set
			// the position instead of the astronaut directly.
			container.copyTransformFrom( startPoint );
			
		}
		
		private function updateEvent(e:Event):void 
		{
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
			
			// There are a lot of ways to manage the camera, the next two functions simplifies a lot all the thing.
			// They work using references, it means, they transform any object relative to another.
			// In this game, the camera is always behind the astronaut, in other words, the camera will be at some
			// position relative to the astronaut. You can see the direction of the axis on the firgure (1). The +Z is pointing to the
			// astronaut direction and +Y is pointing to up. These vector are called Up, Dir and Right (2).
			// The next line of code, sets the camera up (+Y) 80 units and (-Z) 20 units relative to the astronaut.
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 80, -20, container, 0.1 );
			// The final 0.1 value, is called the smooth factor, a value of 0 will produce not movement at all, because it will
			// multiplies the desired movement by 0. A value of 1, will set the camera at the desired position inmediatelly, like if they were linked.
			// A different value will multiply the movement by that factor, Lets say you want to move from 0 to 100 and the smooth factor is 0.5.
			// In the first iteraion you need to move 100 units, but multiplying by 0.5 you'll get only 50 units. On the next iteration your are now on 50 units, so
			// there are another 50 units to reach the 100 units you want, but multiplying by 0.5 again you'll only get 25, so you are now on 75. As you see
			// in each interation you are moving closser to the final value, but in each one you'll move leess units giving a nice easing effect.
			// A small value, will produce slower movements that values closes to 1.
			
			// Now that the camera is on the right position, it needs to "look" at the right position. In se same way you can use references to set the
			// position of the objects, you can aslo use references to look at some point.
			// This method has an additional and optional parameter called 'up' that needs to be used for this game.
			// Usually, the up vector is always pointing to up direction...sounds like maginc!, and by passing a 'null' is enough in most of the cases, Flare3D will calculate
			// the vector for you....but....imagine the folowing example: Put your hand pointing with your (indice) finger at some point like if it were a pistol, and your 
			// (gordo) finger pointing to up, perfect! you have now your dir and up vectors!, now pointing with your finger at the same position, 
			// try to rotate your hand, the up finger will start changing his direction and you can notice that even if you can point always to the same direction,
			// there are many ways you can point to that direction, so how the camera knows where the up vector should be pointing? yes!, that is the 
			// 'up' parameter.
			// In our game, the camera is up to the stronaut, and needs to point to the astronaut looking down, so the up vector of the camera should be pointing
			// to the dir vector of the astronaut, see image (3,4).
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, container, container.getDir(), 0.05 );
		}
	}
}