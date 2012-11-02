package  
{
	import flare.basic.*;
	import flare.core.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Starting the project.
	 */
	public class YellowPlanet_01 extends Sprite 
	{
		private var scene:Scene3D;
		private var planet:Pivot3D;
		private var astronaut:Pivot3D;
		
		public function YellowPlanet_01() 
		{
			// stage setup.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// In this first steps, just change the scene by a Viewer3D to be able to look around the scene.
			scene = new Viewer3D(this);			
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// Loads the external files and stores the references into planet and astronaut objects.
			planet = scene.addChildFromFile( "planet.f3d" );
			astronaut = scene.addChildFromFile( "astronaut.f3d" );
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			trace( "load complete!" );
		}
		
	}

}