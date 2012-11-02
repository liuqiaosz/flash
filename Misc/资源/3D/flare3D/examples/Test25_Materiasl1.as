package 
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	* Working with materials.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test25_Materiasl1 extends Base 
	{
		private var scene:Scene3D;
		private var model:Pivot3D;
		private var normal:Texture3D;
		private var specular:Texture3D;
	
		public function Test25_Materiasl1() 
		{
			super( "Flare3D - Molehill Alien Cow." );
			
			scene = new Viewer3D( this );
			scene.lights.ambientColor.setTo( 0.2, 0.2, 0.2 );
			
			scene.camera = new Camera3D();
			scene.camera.setPosition( 200, 70, 0 );
			scene.camera.lookAt( 0, 70, 0 );
			
			model = scene.addChildFromFile( "../resources/vaca.f3d" );
			specular = scene.addTextureFromFile( "../resources/terrain.png" );
			normal = scene.addTextureFromFile( "../resources/images.jpg" );
			
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent )
			scene.pause();
		}
		
		private function completeEvent(e:Event):void 
		{
			var sFilter:SpecularMapFilter = new SpecularMapFilter( specular, 50, 5 );
			sFilter.repeatX = 2;
			sFilter.repeatY = 2;
			
			var nFilter:NormalMapFilter = new NormalMapFilter( normal );
			nFilter.repeatX = 5;
			nFilter.repeatY = 5;
			
			// gets the original material and adds new filters to it.
			var material:Shader3D = model.getMaterialByName( "Material #360" ) as Shader3D;
			material.filters.push( nFilter );
			material.filters.push( sFilter );
			material.build();
			
			scene.resume();
		}
	}
}

