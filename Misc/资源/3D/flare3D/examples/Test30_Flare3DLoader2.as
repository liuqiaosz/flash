package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Introducing Flare3D Format v2.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test30_Flare3DLoader2 extends Base 
	{
		private var scene:Scene3D;
		
		public function Test30_Flare3DLoader2() 
		{
			super( "Introducing Flare3D Format v2." );
			
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			scene = new Viewer3D( this );
			scene.antialias = 2;
			scene.addChildFromFile( "../resources/planet_v2.f3d" );
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent )
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent )
			
			stage.addEventListener( Event.RESIZE, resizeEvent );
		}
		
		private function resizeEvent(e:Event):void 
		{
			scene.setViewport( 0, 0, stage.stageWidth, stage.stageHeight );
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			trace( "complete" );
		}
	}
}

