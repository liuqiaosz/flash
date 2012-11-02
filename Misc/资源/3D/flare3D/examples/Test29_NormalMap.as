package  
{
	import base.Base;
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
	 * NormalMap test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test29_NormalMap extends Base 
	{
		private var scene:Scene3D;
		private var material:Shader3D;
		private var model:Pivot3D;
		
		private var diffuse:Texture3D;
		private var normal:Texture3D;
		private var environment:Texture3D;
		
		private var light0:Light3D;
		private var light1:Light3D;
		private var light2:Light3D;
		
		public function Test29_NormalMap() 
		{
			super( "Drag to rotate the camera" );
			
			scene = new Viewer3D( this );
			scene.autoResize = true;
			scene.lights.maxPointLights = 3;
			scene.lights.maxDirectionalLights = 0;
			scene.lights.ambientColor.setTo( 0.2, 0.2, 0.2 );
			scene.lights.techniqueName = LightFilter.LINEAR;
			
			light0 = new Light3D();
			light0.setParams( 0xffffff, 500, 1, 1, false );
			light0.setPosition( 100, 0, -100 );
			light0.parent = scene;
			
			light1 = new Light3D();
			light1.setParams( 0xff0000, 500, 1, 1, false );
			light1.setPosition( -100, 100, -100 );
			light1.parent = scene;
			
			light2 = new Light3D();
			light2.setParams( 0x0000ff, 500, 1, 1, false );
			light2.setPosition( 0, 200, 200 );
			light2.parent = scene;
			
			model = scene.addChildFromFile( "../resources/elsa.f3d" );
			diffuse = scene.addTextureFromFile( "../resources/gorda.png" );
			normal = scene.addTextureFromFile( "../resources/images.jpg" );
			environment = scene.addTextureFromFile( "../resources/cell01mod.png" );
			
			scene.pause();
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent )
		}
		
		private function completeEvent(e:Event):void 
		{
			material = new Shader3D( "test" );
			material.filters.push( new TextureFilter( diffuse ) );
			material.filters.push( new NormalMapFilter( normal ) );
			material.filters.push( new SpecularFilter( 50, 3 ) );
			material.build();
			
			NormalMapFilter(material.filters[1]).repeatX = 10;
			NormalMapFilter(material.filters[1]).repeatY = 10;
			
			model.setMaterial( material );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			scene.resume();
		}
		
		private function updateEvent(e:Event):void 
		{
			light0.x = Math.cos( getTimer() / 1300 ) * 300;
			
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) scene.lights.techniqueName = LightFilter.NO_LIGHTS;
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) scene.lights.techniqueName = LightFilter.PER_VERTEX;
			if ( Input3D.keyHit( Input3D.NUMBER_3 ) ) scene.lights.techniqueName = LightFilter.LINEAR;
			if ( Input3D.keyHit( Input3D.NUMBER_4 ) ) scene.lights.techniqueName = LightFilter.SAMPLED;
		}
	}
}

