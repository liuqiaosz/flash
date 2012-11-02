package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.events.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flash.display3D.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	/**
	 * This example creates a stroke fake or border around the 3d models.
	 * Is a very old trick, but it is very fast and easy to implement.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test28_Stroke extends Base 
	{
		private var scene:Scene3D;
		private var stroke:Mesh3D;
		
		public function Test28_Stroke() 
		{
			scene = new Viewer3D(this);
			scene.camera = new Camera3D();
			scene.camera.setPosition( 0, 0, -200 );
			scene.camera.lookAt( 0, 0, 0 );
			
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.addChildFromFile( "../resources/elsa.f3d" );			
		}
		
		private function completeEvent(e:Event):void 
		{
			// gets the loaded 'elsa' model.
			var model:Mesh3D = scene.getChildByName( "elsa" ) as Mesh3D;
			
			var clone1:Mesh3D = model.clone() as Mesh3D;
			clone1.x = -80;
			
			var clone2:Mesh3D = model.clone() as Mesh3D;
			clone2.x = 80;
			
			scene.addChild( clone1 );
			scene.addChild( clone2 );
			
			var strokeMaterial:Shader3D = new Shader3D( "stroke", [new ColorFilter( 0xff0000 )], false );
			// culiing the front faces will cause that only the back faces will be visibles.
			strokeMaterial.cullFace = Context3DTriangleFace.FRONT;
			
			// scale a bit the model in order to get the edges.
			stroke = model.clone() as Mesh3D;
			stroke.setScale( 1.05, 1.05, 1.05 );
			stroke.setMaterial( strokeMaterial );
			stroke.parent = scene;
			
			model.addEventListener( MouseEvent3D.MOUSE_OVER, mouseOverEvent );
			clone1.addEventListener( MouseEvent3D.MOUSE_OVER, mouseOverEvent );
			clone2.addEventListener( MouseEvent3D.MOUSE_OVER, mouseOverEvent );
		}
		
		private function mouseOverEvent(e:MouseEvent3D):void 
		{
			var target:Pivot3D = e.info.mesh;
			
			stroke.setPosition( target.x, target.y, target.z );
		}
		
	}

}