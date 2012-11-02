package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flash.display.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Custom mesh test.
	 * 
	 * @author Ariel Nehmad.
	 */
	public class Test14_CustomMesh3D extends Sprite 
	{
		private var scene:Scene3D;
		private var mesh:Mesh3D;
		
		public function Test14_CustomMesh3D() 
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			scene = new Viewer3D(this);
			scene.camera.setPosition( 0, 20, -30 );
			scene.camera.lookAt( 0, 0, 0 );
			
			mesh = new Mesh3D();
			mesh.surfaces[0] = new Surface3D();
			mesh.surfaces[0].addVertexData( Surface3D.POSITION, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.NORMAL, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.UV0, 2 );
			
												// position,   	normal,  	uv0 
			mesh.surfaces[0].vertexVector.push( -10, 0, 10, 	0, 1, 0, 	0, 0,
												 10, 0, 10, 	0, 1, 0, 	1, 0,
												-10, 0, -10, 	0, 1, 0, 	0, 1,
												 10, 0, -10, 	0, 1, 0, 	1, 1 );
			
			mesh.surfaces[0].indexVector.push( 0, 1, 2, 
											   1, 3, 2 );
			
			var shader:Shader3D = new Shader3D( "material", [new TextureFilter()] );
			shader.twoSided = true;
			
			mesh.surfaces[0].material = shader;			
			
			var clone:Mesh3D = mesh.clone() as Mesh3D;
			clone.setRotation( 23, 10, 56 );
			clone.y = 10;
			
			scene.addChild( mesh );
			scene.addChild( clone );
		}
		
	}

}