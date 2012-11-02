package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	/**
	 * Alpha sorting test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test35_AlphaSorting extends Base
	{
		private var scene:Viewer3D;
		private var mode:int;
		private var info:TextField;
		
		public function Test35_AlphaSorting() 
		{
			super( "Alpha sort test: Press SPACE to change the sort mode." );
			
			info = new TextField();
			info.textColor = 0xffffff;
			info.autoSize = "left";
			info.y = 15;
			addChild( info );
			
			scene = new Viewer3D(this);
			scene.camera = new Camera3D();
			scene.camera.setPosition( 0, 0, -200 );
			scene.autoResize = true;
			scene.antialias = 2;
			scene.setLayerSortMode(10, Scene3D.SORT_NONE);
			
			var mat:Shader3D = new Shader3D( "", [new ColorFilter(0xff0000, 0.2)]);
			var cube:Cube = new Cube( "cube", 10, 10, 10, 1, mat )
			
			for ( var i:int = 0; i < 300; i++ )
			{
				var d:Mesh3D = cube.clone() as Mesh3D;
				d.x = Math.random() * 100 - 50;
				d.y = Math.random() * 100 - 50;
				d.z = Math.random() * 100 - 50;
				d.setLayer( 10 );
				scene.addChild( d );
			}
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			if ( Input3D.keyHit( Input3D.SPACE ) )
			{
				if ( ++mode > 2 ) mode = 0;
				
				switch(mode)
				{
					case 0: scene.setLayerSortMode(10, Scene3D.SORT_NONE); break;
					case 1: scene.setLayerSortMode(10, Scene3D.SORT_FRONT_TO_BACK); break;
					case 2: scene.setLayerSortMode(10, Scene3D.SORT_BACK_TO_FRONT); break;
				}
			}
			
			if ( !Input3D.mouseDown ) scene.camera.rotateY( 1, false, Vector3DUtils.ZERO );
			
			if (mode == 0) info.text = "Sort mode: NONE";
			else if (mode == 1) info.text = "Sort mode: SORT_FRONT_TO_BACK";
			else if (mode == 2) info.text = "Sort mode: SORT_BACK_TO_FRONT";
		}
	}
}