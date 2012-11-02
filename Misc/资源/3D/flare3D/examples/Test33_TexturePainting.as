package  
{
	import base.*;
	import flare.basic.*;
	import flare.collisions.*;
	import flare.core.*;
	import flare.events.*;
	import flare.materials.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	/**
	 * Texture painting example.
	 * 
	 * @author Ariel Nehmad.
	 */
	public class Test33_TexturePainting extends Base 
	{
		private var scene:Scene3D;
		private var shape:Shape;
		private var texture:Texture3D;
		
		public function Test33_TexturePainting() 
		{
			scene = new Viewer3D(this);
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.addChildFromFile( "../resources/elsa.f3d" );
			
			shape = new Shape();
			shape.graphics.beginFill( 0xff0000, 1 );
			shape.graphics.drawCircle( 10, 10, 10 );
		}
		
		private function completeEvent(e:Event):void 
		{
			var mesh:Mesh3D = scene.getChildByName( "elsa" ) as Mesh3D;
			
			// get the mesh material.
			var material:Shader3D = mesh.getMaterialByName( "mElsa" ) as Shader3D;
			
			// get the texture associated and change the mip mode to not generate 
			// mip levels for the texture. this will increase performance.
			texture = material.filters[0].texture;
			texture.mipMode = Texture3D.MIP_NONE;
			
			// rebuild the material because we changed the texture mip mode.
			// so, the shader should be recompiled.
			material.build();
			
			mesh.addEventListener( MouseEvent3D.MOUSE_MOVE, mouseMoveEvent );
			mesh.useHandCursor = true;
		}
		
		private function mouseMoveEvent(e:MouseEvent3D):void 
		{
			var info:CollisionInfo = e.info;
			
			var bitmapData:BitmapData = texture.bitmapData;
			
			var matrix:Matrix = new Matrix();
			matrix.tx = info.u * bitmapData.width;
			matrix.ty = info.v * bitmapData.height;
			
			bitmapData.draw( shape, matrix );
			
			// upload the texture to the graphics card again.
			texture.upload(scene);
		}
	}
}