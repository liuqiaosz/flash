package  
{
	import flare.basic.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import mesh.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class Test18_CubeMesh extends Sprite
	{
		private var scene:Scene3D;
		private var cubes:CubesMesh;
		private var count:Number = 0;
		private var info:TextField;
		
		public function Test18_CubeMesh() 
		{
			stage.scaleMode = "noScale";
			stage.align = "tl";
			
			scene = new Viewer3D( this );
			scene.camera.setPosition( 0, 0, -1300 );			
			
			cubes = new CubesMesh();
			
			var total:int = 256 * 256;
			for ( var i:int = 0; i < total; i++ )
			{
				var x:Number = Math.random() * 1000 - 500;
				var y:Number = Math.random() * 1000 - 500;
				var z:Number = Math.random() * 1000 - 500;
				var color:Number = Math.random() * 0.99 + 0.01;				
				cubes.addCube( x, y, z, 5, color );
			}

			scene.addChild( cubes );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}		
		
		private function updateEvent(e:Event):void 
		{
			if ( !Input3D.mouseDown )
			{
				count++
				cubes.rotateX( 0.2 );
				cubes.rotateZ( 0.22 );
				scene.camera.translateZ( Math.sin( count / 150 ) * 5 );
			}
		}
	}
}