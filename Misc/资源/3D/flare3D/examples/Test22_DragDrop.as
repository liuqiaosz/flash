package  
{
	import base.Base;
	import flare.basic.*;
	import flare.core.*;
	import flare.events.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Drag & Drop with 3D objects.
	 * @author Ariel Nehmad
	 */
	public class Test22_DragDrop extends Base 
	{
		private var scene:Scene3D;
		private var draging:Boolean = false;
		
		public function Test22_DragDrop() 
		{
			super( "Drag & Drop with 3D objects." );
			
			scene = new Scene3D( this );
			scene.camera = new Camera3D();
			scene.camera.setPosition( 200, 100, -200 );
			scene.camera.lookAt( 0, 0, 0 );
			scene.antialias = 2;
			scene.autoResize = true;
			
			var mat:Shader3D = new Shader3D( "plane", [new ColorFilter(0x90f090)] );
				mat.twoSided = true;
				
			var sphere:Sphere = new Sphere( "sphere", 10 );
			var plane:Plane = new Plane( "", 40, 40, 1, mat );
				plane.parent = sphere;
			
			for ( var i:int = 0; i < 20; i++ )
			{
				var object:Mesh3D = sphere.clone() as Mesh3D;
				object.addEventListener( MouseEvent3D.MOUSE_DOWN, mouseDownEvent );
				object.addEventListener( MouseEvent3D.MOUSE_UP, mouseUpEvent );
				object.x = Math.random() * 100 - 50;
				object.y = Math.random() * 100 - 50;
				object.z = Math.random() * 100 - 50;
				object.parent = scene;
			}
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			if ( draging == false && Input3D.mouseDown && Input3D.mouseMoved )
			{
				scene.camera.rotateY( Input3D.mouseXSpeed, false, Vector3DUtils.ZERO );
				scene.camera.rotateX( Input3D.mouseYSpeed, true, Vector3DUtils.ZERO );
			}
		}
		
		private function mouseDownEvent(e:MouseEvent3D):void 
		{
			var target:Pivot3D = e.target as Pivot3D;
			
			/* this drag relative to the camera orientation. */
			
			target.startDrag( true );
			
			/* this drag relative to the object plane orientation. */
			
			//target.startDrag( true, target.getDir(false) );
			
			draging = true;
		}
		
		private function mouseUpEvent(e:MouseEvent3D):void 
		{
			var target:Pivot3D = e.target as Pivot3D;
			
			target.stopDrag();
			
			draging = false;
		}
	}

}