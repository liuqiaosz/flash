package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.materials.flsl.*;
	import flash.display.*;
	import flash.utils.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Vertex Colors example.
	 * 
	 * @author Ariel Nehmad.
	 */
	public class Test31_VertexColors_FLSL extends Sprite 
	{
		private var scene:Scene3D;
		private var mesh:Mesh3D;
		
		[Embed(source = 'filters/vertexColors.flsl', mimeType = 'application/octet-stream')]
		private static var FilterSource:Class;
		private static var colorFilterBytes:ByteArray = FLSLCompiler.compile( new FilterSource );
		
		public function Test31_VertexColors_FLSL() 
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			scene = new Viewer3D( this );
			scene.camera.setPosition( 0, 20, -30 );
			scene.camera.lookAt( 0, 0, 0 );
			
			mesh = new Mesh3D();
			mesh.surfaces[0] = new Surface3D();
			mesh.surfaces[0].addVertexData( Surface3D.POSITION, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.NORMAL, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.UV0, 2 );
			mesh.surfaces[0].addVertexData( Surface3D.COLOR0, 4 );
			
												// position,   	normal,  	uv0 	colors
			mesh.surfaces[0].vertexVector.push( -10, 0, 10, 	0, 1, 0, 	0, 0,	1, 0, 0, 1,
												 10, 0, 10, 	0, 1, 0, 	1, 0,	0, 1, 0, 1,
												-10, 0, -10, 	0, 1, 0, 	0, 1,	0, 0, 1, 1,
												 10, 0, -10, 	0, 1, 0, 	1, 1,	1, 1, 0, 1 );
			
			mesh.surfaces[0].indexVector.push( 0, 1, 2, 
											   1, 3, 2 );
			
			var shader:Shader3D = new Shader3D();
				shader.filters.push( new TextureFilter() );
				shader.filters.push( new FLSLFilter( colorFilterBytes, BlendMode.MULTIPLY ) );
				shader.build();
				
			mesh.surfaces[0].material = shader;			
			mesh.surfaces[0].material.twoSided = true;
			
			var clone:Mesh3D = mesh.clone() as Mesh3D;
			clone.setRotation( 23, 10, 56 );
			clone.y = 10;
			
			scene.addChild( mesh );
			scene.addChild( clone );
		}
	}
}