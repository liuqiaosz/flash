package  
{
	import base.*;
	import components.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.events.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * A bunch of planes textured with alpha mask and mouse events test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test12_Mouse_And_Planes extends Base 
	{
		[Embed(source='../resources/tree.png')]
		private var Texture:Class;
		
		private var scene:Scene3D;
		
		public function Test12_Mouse_And_Planes() 
		{
			scene = new Viewer3D(this);
			scene.camera.setPosition( 0, 0, -100 );
			
			var texture:Texture3D = new Texture3D( new Texture().bitmapData );
			var material:Shader3D = new Shader3D( "", null, false  /* you can turn on/off the lights depend of your needs. */ );
				material.filters.push( new TextureFilter( texture ) ); // out texture with alpha.
				material.filters.push( new AlphaMaskFilter( 0.5 ) ); // this filter apply a mask based on a threshold using the alpha channel.
				material.twoSided = true;
				material.build();
				
			var plane:Plane = new Plane( "sourcePlane", 10, 10, 1, material );
			
			for ( var i:int = 0; i < 200; i++ )
			{
				var clone:Mesh3D = plane.clone() as Mesh3D;
				clone.name = "plane" + i;
				clone.x = Math.random() * 100 - 50;
				clone.y = Math.random() * 100 - 50;
				clone.z = Math.random() * 100 - 50;
				clone.addEventListener( MouseEvent3D.MOUSE_OVER, mouseOverEvent );
				clone.addEventListener( MouseEvent3D.MOUSE_OUT, mouseOutEvent );
				clone.addEventListener( MouseEvent3D.MOUSE_MOVE, mouseMoveEvent );
				clone.useHandCursor = true;
				scene.addChild( clone );
			}
		}
		
		private function mouseMoveEvent(e:MouseEvent3D):void 
		{
			e.target.rotateZ( 2 );
		}
		
		private function mouseOverEvent(e:MouseEvent3D):void 
		{
			e.target.setScale( 1.2, 1.2, 1.2 );
		}
		
		private function mouseOutEvent(e:MouseEvent3D):void 
		{
			e.target.setScale( 1, 1, 1 );
		}
	}
}