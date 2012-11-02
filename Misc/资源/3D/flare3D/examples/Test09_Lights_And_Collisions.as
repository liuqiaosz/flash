package  
{
	import base.*;
	import flare.basic.*;
	import flare.collisions.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Simple game with lights and collisions.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test09_Lights_And_Collisions extends Base 
	{
		private var scene:Scene3D;
		private var player:Pivot3D;
		private var collisions:SphereCollision;
		private var light0:Light3D;
		
		// some player variables.
		private var jump:Boolean = false;
		private var velocity:Vector3D = new Vector3D();
		private var friction:Vector3D = new Vector3D(0.6, 1, 0.6);
		private var oldPosition:Vector3D = new Vector3D();
		
		public function Test09_Lights_And_Collisions() 
		{
			super( "Dynamic lights and collisions.\n" + 
				   "Use SPACE to jump, W,S,A,D to move and drag to look around.\n" +
				   "Keys 1,2,3,4 to swich between diferent light modes." );
			
			scene = new Scene3D(this);
			
			// set the color to clear the back buffer.
			scene.clearColor.setTo( 0.7, 0.4, 0.2 );
			
			// set the antialias value 1, 2, 3...8.
			scene.antialias = 0;
			
			// deactivate the default lights, we will use the lights included on the map file.
			scene.defaultLight = null
			
			// lights are cool, but they are not free :)
			// by default the scene has one LightFilter instante that takes care about all scene lights.
			// filters in flare3d are similar to flash filters, they just apply nice effects
			// with parameters (or not) on any flare3d material that support filters (Shader3D).
			// by default, the LightFilter uses 4 point light and 1 directional.
			// this is "not" a real scenario, usually is higly recomended to bake static lights.
			// but for this demo, we'll use a brute force configuration, so we'll use 12 point lights.
			// the scene will take the closer lights automatically at render time.
			scene.lights.maxPointLights = 7;
			// we don't have directional lights, so we set it to 0.
			scene.lights.maxDirectionalLights = 0;
			// and set the ambient color.
			scene.lights.ambientColor = new Vector3D( 0.1, 0.1, 0.1 );
			
			// load the map.
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addChildFromFile( "../resources/map.f3d" );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener( Event.RESIZE, resizeEvent );
			
			// this wil be our player.
			player = new Pivot3D( "ourPlayer" );
			player.parent = scene;
			player.setPosition( 0, 100, -100 );
			oldPosition.copyFrom( player.getPosition() );
			
			// creates and parents the camera to the player.
			scene.camera = new Camera3D( "ourCamera" );
			scene.camera.y = 20;
			scene.camera.parent = player;
			scene.showLogo = false;
		}		
		
		private function progressEvent(e:Event):void 
		{
			// scene loadgin progress.
			//trace( scene.loadProgress );
		}
		
		private function resizeEvent(e:Event):void 
		{
			// if the stage change his size, resize the scene3d too.
			scene.setViewport( 0, 0, stage.stageWidth, stage.stageHeight, scene.antialias );
		}
		
		private function completeEvent(e:Event):void 
		{
			// get access to one of the lights to turn on/off the light on the game.
			light0 = scene.getChildByName( "Omni032" ) as Light3D;
			
			// creates the collision manager.
			collisions = new SphereCollision( player, 25 );
			// includes all the scene to test for collisions. again, this is a simply and brute force
			// demo, in real life, you need to create a light/low poly mesh for collisions ;)
			// try to compile in release mode to get better results.
			collisions.addCollisionWith( scene );
			
			// once the scene is completly loaded, start to update the game!.
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// simulate the broken light. 
			if ( Math.random() > 0.5 ) 
				light0.visible = true 
			else 
				light0.visible = false;
			
			// swith between diferent light configurations.
			// by default is seted to sampled lights. each method has diferent behaviors and properties we'll detail later.
			// they are sorted from low to high performance impact.
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) scene.lights.techniqueName = LightFilter.NO_LIGHTS;
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) scene.lights.techniqueName = LightFilter.PER_VERTEX;
			if ( Input3D.keyHit( Input3D.NUMBER_3 ) ) scene.lights.techniqueName = LightFilter.LINEAR;
			if ( Input3D.keyHit( Input3D.NUMBER_4 ) ) scene.lights.techniqueName = LightFilter.SAMPLED;
			
			// if the mouse is pressed, start to drag the camera/player.
			if ( Input3D.mouseDown )
			{
				// rotate the player over the y/up axis.
				player.rotateY( Input3D.mouseXSpeed );
				
				// because the camera is parented to the player, we just
				// rotate the camera/head only over the x/right axis.
				scene.camera.rotateX( Input3D.mouseYSpeed );
			}
			
			// do some physics.
			var playerVel:Number = 1.5;
			
			// if shift key is pressed, duplicate the player velocity.
			if ( Input3D.keyDown( Input3D.SHIFT ) ) playerVel *= 2;
			
			// basic player translations.
			if ( Input3D.keyDown( Input3D.A ) ) player.translateX( -playerVel );
			if ( Input3D.keyDown( Input3D.D ) ) player.translateX( playerVel );
			if ( Input3D.keyDown( Input3D.S ) ) player.translateZ( -playerVel );
			if ( Input3D.keyDown( Input3D.W ) ) player.translateZ( playerVel );
			
			// if we are not jumping.....jump!
			if ( !jump && Input3D.keyHit( Input3D.SPACE ) )
			{
				// we'll use the current and old position to calculate the player velocity,
				// so, it looks like we are just translating the player,
				// but we are really increasing the speed.
				player.translateY( 10 ); 
				jump = true;
			}
			
			// update the player position and apply some gravity.
			player.x += velocity.x;
			player.y += velocity.y - 0.75;
			player.z += velocity.z;
			
			// once, we move the player, test if it is colliding with something.
			if ( collisions.slider() )
			{
				// if it collided with something, get the firt collision data.
				var info:CollisionInfo = collisions.data[0];
				
				// if the y/up axis of the normal is greater than the 'x' and 'z', so 
				// we problably collided with the floor. set the jump flag to false again.
				if ( info.normal.y > 0.8 ) jump = false;
			}
			
			// update the player velocity and apply some friction.
			velocity.x = ( player.x - oldPosition.x ) * friction.x;
			velocity.y = ( player.y - oldPosition.y ) * friction.y;
			velocity.z = ( player.z - oldPosition.z ) * friction.z;
			
			// store the las position.
			oldPosition.copyFrom( player.getPosition() );
		}
	}
}