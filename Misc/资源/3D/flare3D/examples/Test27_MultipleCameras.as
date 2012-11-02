package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Multiple cameras test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test27_MultipleCameras extends Base 
	{
		private var scene:Scene3D;
		private var secondCamera:Camera3D;
		private var model:Pivot3D;
		
		public function Test27_MultipleCameras() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			scene = new Viewer3D(this);
			scene.antialias = 2;
			scene.camera = new Camera3D( "mainCamera" );
			scene.camera.setPosition( 0, 100, -100 );
			scene.camera.lookAt( 0, 40, 0 );
			
			model = scene.addChildFromFile( "../resources/map.f3d" );
			
			// creates the second camera.
			secondCamera = new Camera3D( "second camera", 60 );
			secondCamera.viewPort = new Rectangle( 20, 20, 250, 150 );
			
			// we need to draw the caemra in postRender event because the render method will
			// also dispatch the render event.
			scene.addEventListener( Scene3D.POSTRENDER_EVENT, postRenderEvent );
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			stage.addEventListener( Event.RESIZE, resizeStageEvent );
		}
		
		private function resizeStageEvent(e:Event):void 
		{
			scene.setViewport( 0, 0, stage.stageWidth, stage.stageHeight );
		}
		
		private function updateEvent(e:Event):void 
		{
			// just for fun :)
			secondCamera.setPosition( 0, 40, 0 );
			secondCamera.rotateY( 0.5 );
		}
		
		private function postRenderEvent(e:Event):void 
		{
			graphics.clear();
			graphics.lineStyle( 1, 0xff0000 );
			graphics.drawRect( 20, 20, 250, 150 );
			
			// here we draw the other cameras.
			scene.render( secondCamera, true );
		}
	}
}