package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Materials.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test10_Lights_And_Materials extends Base
	{
		private var scene:Scene3D;
		private var elsa:Pivot3D;
		
		private var texture0:Texture3D;
		private var texture1:Texture3D;
		private var texture2:Texture3D;
		private var texture3:Texture3D;
		
		private var material0:Shader3D;
		private var material1:Shader3D;
		private var material2:Shader3D;
		private var material3:Shader3D;
		private var material4:Shader3D;
		private var material5:Shader3D;
		
		private var light:Light3D;
		
		public function Test10_Lights_And_Materials() 
		{
			super( "Materials and Lights - Drag to rotate the camera" );
			
			scene = new Viewer3D( this );
			scene.autoResize = true;
			scene.camera = new Camera3D();
			scene.camera.setPosition( 150, 150, -300 );
			scene.camera.lookAt( 0, 0, 0 );
			
			// light setup should be at the first to avoid duplicated shader compilations.
			scene.defaultLight.color.setTo( 0.3, 0.3, 0.3 );
			scene.lights.maxPointLights = 1;
			
			light = new Light3D();
			light.setPosition( 0, 300, -400 );
			scene.addChild( light )
			
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			texture0 = scene.addTextureFromFile( "../resources/r42.jpg" );
			texture1 = scene.addTextureFromFile( "../resources/mask.png" );
			texture2 = scene.addTextureFromFile( "../resources/gorda.png" );
			texture3 = scene.addTextureFromFile( "../resources/rusty.png" );
			
			elsa = scene.addChildFromFile( "../resources/elsa.f3d" );
		}
		
		private function completeEvent(e:Event):void 
		{
			var clone1:Pivot3D = elsa.clone();
			var clone2:Pivot3D = elsa.clone();			
			var clone3:Pivot3D = elsa.clone();			
			var clone4:Pivot3D = elsa.clone();
			var clone5:Pivot3D = elsa.clone();
			scene.addChild( clone1 );
			scene.addChild( clone2 );
			scene.addChild( clone3 );
			scene.addChild( clone4 );
			scene.addChild( clone5 );			
			clone1.x = -150;
			clone2.x = 50;
			clone3.x = 150;			
			clone4.z = 100;
			clone5.z = -100;
			elsa.x = -50
			
			// get access to the mesh material.
			material0 = elsa.getMaterialByName( "mElsa" ) as Shader3D;
			// this is a basic standard material, the only filter is a TextureFilter.
			material0.filters[0].alpha = 0.75;
			// set the layer to a high value to draw it after all other objects
			// and get a correct alpha blending.
			elsa.setLayer( 10 );
			
			// test 1.
			material1 = new Shader3D( "test1" );
			material1.filters.push( new TextureFilter( new Texture3D( "../resources/r42.jpg" ) ) );
			material1.filters.push( new TextureFilter( texture1 ) ); // texture with alpha.
			material1.build();
			clone1.setMaterial( material1 );
			
			// test 2.
			material2 = new Shader3D( "test2" );
			material2.filters.push( new TextureFilter( texture2 ) );
			material2.filters.push( new EnvironmentFilter( texture3, BlendMode.MULTIPLY, 2 ) );
			material2.build();
			clone2.setMaterial( material2 );
			
			// test 3 - clone the material and add a new filter.
			material3 = material2.clone() as Shader3D;
			material3.filters.push( new ColorFilter( 0xff0000, 1, BlendMode.MULTIPLY ) );
			material3.filters.push( new SpecularFilter( 200, 10 ) );
			material3.build();
			clone3.setMaterial( material3 );
			
			// test 4 - no lights.
			material4 = new Shader3D( "test4", null, false );
			material4.filters = material1.filters; // if we set the filters directly, don't need to call the build() method to compile.
			clone4.setMaterial( material4 );
			
			// test 5 - alpha mask.
			material5 = new Shader3D( "test5" );
			material5.filters.push( new TextureFilter( texture1 ) );
			material5.filters.push( new AlphaMaskFilter( 0.5 ) );
			material5.build();
			material5.twoSided = true;
			clone5.setMaterial( material5 );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			light.x = Math.cos( getTimer() / 1000 ) * 500;
			light.y = 500
			light.z = Math.sin( getTimer() / 1000 ) * 500;
			
			// modify the ColorFilter.
			material3.filters[2].r = Math.cos( getTimer() / 600 ) * 0.5 + 0.5;
			material3.filters[2].g = Math.cos( getTimer() / 700 ) * 0.5 + 0.5;
			material3.filters[2].b = Math.cos( getTimer() / 800 ) * 0.5 + 0.5;
			
			// swith between diferent light configurations.
			// in this case, there almost no diference between de lights models, apart of no_lights mode.
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) scene.lights.techniqueName = LightFilter.NO_LIGHTS;
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) scene.lights.techniqueName = LightFilter.PER_VERTEX;
			if ( Input3D.keyHit( Input3D.NUMBER_3 ) ) scene.lights.techniqueName = LightFilter.LINEAR;
			if ( Input3D.keyHit( Input3D.NUMBER_4 ) ) scene.lights.techniqueName = LightFilter.SAMPLED;
		}
	}
}