package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * The Input3D.
	 * 
	 * @author Ariel Nehamd
	 */
	public class Test03_Input3D extends Base
	{
		private var scene:Scene3D;
		private var car:Pivot3D;
		private var axis:Pivot3D;
		
		public function Test03_Input3D() 
		{
			super( "The Input3D Class. Press UP, DOWN, LEFT and RIGHT to move the car and 'R' to reset to the original position." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// creates a new 3d scene.
			scene = new Viewer3D( this );
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( -20, 20, -20 );
			scene.camera.lookAt( 0, 0, 0 );
			
			// add global scene progress and complete events.
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// loads the objects.
			car = scene.addChildFromFile( "../resources/car.f3d" );
			axis = scene.addChildFromFile( "../resources/axis.f3d" );
			
			// this prevents to flare3d to start render before the objects are completly loaded.
			scene.pause();
		}
		
		private function progressEvent(e:Event):void 
		{
			// gets the global loading progress.
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			// once the scene has been loaded, resume the render.
			scene.resume();
			
			// start to update the scene.
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// translates the car locally. Whatever the rotation is, the car always will move forward.
			if ( Input3D.keyDown( Input3D.UP ) ) car.translateZ( 0.5 );
			if ( Input3D.keyDown( Input3D.DOWN ) ) car.translateZ( -0.5 );
			
			// rotate the car over the y-up axis.
			if ( Input3D.keyDown( Input3D.LEFT ) ) car.rotateY( -3 );
			if ( Input3D.keyDown( Input3D.RIGHT ) ) car.rotateY( 3 );
			
			// different from keyDown, keyHit returns 'true' only once,
			// after the key is pressed it will return 'false' until the key is released again.
			if ( Input3D.keyHit( Input3D.R ) )
			{
				// just reset the car position and rotation.
				car.setPosition( 0, 0, 0 );
				car.setRotation( 0, 0, 0 );
			}
		}
	}
}