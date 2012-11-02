package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Access to the objects of the hierarchy, moving objects, applying transformations.
	 * And applying some crazy factors.
	 * 
	 * @author Ariel Nehamd
	 */
	public class Test05_Movements extends Base
	{
		private var scene:Scene3D;
		
		private var car:Pivot3D;
		private var carSpeed:Number = 0;
		private var carRotation:Number = 0;
		
		private var whell1:Pivot3D;
		private var whell2:Pivot3D;
		private var whell3:Pivot3D;
		private var whell4:Pivot3D;
		private var whellRotation:Number = 0;
		
		public function Test05_Movements() 
		{
			super( "Move the car using the UP, DOWN, LEFT and RIGHT keys." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// creates a new 3d scene.
			scene = new Scene3D( this );
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 20, -10 );
			scene.camera.lookAt( 0, 0, 0 );
			
			// add global scene progress and complete events.
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// loads the objects.
			car = scene.addChildFromFile( "../resources/car.f3d" );
			
			scene.addChildFromFile( "../resources/plane.f3d" );
			
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
			
			// this stops the car animation.
			car.stop();
			
			// get access to the front whells.
			whell1 = car.getChildByName( "AXTruck-FLWheel" );
			whell2 = car.getChildByName( "AXTruck-FLWheel001" );
			
			// get access to the back whells.
			whell3 = car.getChildByName( "AXTruck-BLWheel" );
			whell4 = car.getChildByName( "AXTruck-BLWheel001" );
			
			// start to update the scene.
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// translates the car locally. Whatever the rotation is, the car always will move forward.
			if ( Input3D.keyDown( Input3D.UP ) ) carSpeed += 0.1;
			if ( Input3D.keyDown( Input3D.DOWN ) ) carSpeed -= 0.1;
			
			// rotate the car over the y-up axis.
			if ( Input3D.keyDown( Input3D.LEFT ) ) carRotation -= 6;
			if ( Input3D.keyDown( Input3D.RIGHT ) ) carRotation += 6;
			
			// apply some factor to reduce the speed and rotations gradually.
			carSpeed *= 0.9;
			carRotation *= 0.9;
			
			// increment the rotation along the 'x' axis.
			// we uses this, becase we are using absolute rotations for the whell1 and whell2.
			whellRotation += carSpeed * 10;
			
			// for thr front whells, we use absolute rotations.
			whell1.setRotation( whellRotation, carRotation, 0 );
			whell2.setRotation( whellRotation, carRotation, 0 );
			
			// for the back whells we can just rotate them locally.
			whell3.rotateX( carSpeed * 8 );
			whell4.rotateX( carSpeed * 8 );
			
			// rotate the car locally acording the car rotation speed and car speed.
			// and apply some factor to reduce the rotation.
			car.rotateY( carRotation * carSpeed / 20 );
			
			// translate the car along his local z/front direction.
			car.translateZ( carSpeed );
			
			// setup the camera, see Test04.
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 10, -10, car, 0.2 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 5, 0, car );
		}
	}
}