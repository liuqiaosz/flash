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
	 * Clones!
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test07_Clones extends Base 
	{
		private var scene:Scene3D;		
		private var model:Pivot3D;
		
		public function Test07_Clones() 
		{
			super( "The attack of the cloned cows." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// creates and load the scene.
			scene = new Viewer3D( this );
			scene.pause();
			
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			model = scene.addChildFromFile( "../resources/vaca2.f3d" );
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			trace( "complete" );
			
			var count:int = 20;
			
			for ( var h:int = 0; h < count; h++ )
			{
				for ( var v:int = 0; v < count; v++ )
				{
					var space:Number = 240;
					var cloned:Pivot3D = model.clone();
					cloned.x = h * space - space * count / 2;
					cloned.z = v * space - space * count / 2;
					// when some models share the same frame, it could be much faster.
					// also sorting skinned models into layers could optimize the render and reuse information.
					// this is the worst case, when all models had differents and random frames and frameRates.
					cloned.frameSpeed = Math.random() + 0.5;
					// this is the same as scene.addChild();
					cloned.parent = scene;
				}
			}
			
			// camera posiion and orientation.
			scene.camera = new Camera3D();
			scene.camera.setPosition( 1000, 1000, 1000 );
			scene.camera.lookAt( 0, 0, 0 );
			scene.camera.far = 10000;
			
			scene.play();
			
			// remove the original and father of all clones.
			scene.removeChild( model );			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			scene.resume();
		}
		
		private function updateEvent(e:Event):void 
		{
			if ( Input3D.keyHit( Input3D.P ) ) scene.play()
			if ( Input3D.keyHit( Input3D.S ) ) scene.stop()
		}		
	}
}