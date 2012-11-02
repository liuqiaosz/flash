package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * The basics, easy!.
	 * 
	 * @author Ariel Nehamd
	 */
	public class Test01_The_Basics1 extends Base
	{
		private var scene:Scene3D;
		private var car:Pivot3D;
		private var axis:Pivot3D;
		
		public function Test01_The_Basics1() 
		{
			super( "Basics 1 - Drag to look around." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// creates a new 3d scene.
			scene = new Viewer3D( this );
			scene.antialias = 2;
			
			// add global scene progress and complete events.
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// loads the objects.
			car = scene.addChildFromFile( "../resources/car.f3d" );
			axis = scene.addChildFromFile( "../resources/axis.f3d" );
		}
		
		private function progressEvent(e:Event):void 
		{
			// gets the global loading progress.
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			trace( "complete!" );
			
			// just scale the model.
			axis.setScale( 0.5, 0.5, 0.5 );
		}
	}
}