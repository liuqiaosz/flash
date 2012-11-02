package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * How to build a new planet.
	 * @author Ariel Nehmad.
	 */
	public class Test21_Planet extends Base 
	{
		private var scene:Scene3D;
		private var planet:Shader3D;
		private var atmosphere:Shader3D;
		private var sph1:Sphere;
		private var sph2:Sphere;
		
		public function Test21_Planet() 
		{
			super( "How to build a new planet." );
			
			scene = new Viewer3D(this);
			scene.antialias = 2;
			scene.clearColor.setTo( 0, 0, 0 );
			scene.camera.setPosition( 0, 0, -150 );
			scene.lights.ambientColor.setTo( 0, 0, 0 );
			scene.lights.maxPointLights = 1;
			scene.defaultLight = null;
			
			var light:Light3D = new Light3D();
			light.setPosition( 1000, 1000, -1000 );
			
			var texture1:Texture3D = scene.addTextureFromFile( "../resources/tex6.jpg" );
			var texture2:Texture3D = scene.addTextureFromFile( "../resources/material16.png" );
			
			planet = new Shader3D( "planetMaterial" );
			planet.filters.push( new TextureFilter( texture1 ) );
			planet.build();
			
			atmosphere = new Shader3D( "atmosphereMaterial", null, true );
			atmosphere.filters.push( new EnvironmentFilter( texture2, BlendMode.NORMAL, 2 /* saturate a bit the texture. */ ) );
			atmosphere.sourceFactor = "one"; // additive blend mode one & one.
			atmosphere.destFactor = "one";
			atmosphere.build();
			
			sph1 = new Sphere( "planet", 50, 32, planet )
			sph2 = new Sphere( "atmosphere", 51, 32, atmosphere )
			sph2.layer = 2; // force to render after the other objects.
			
			scene.addChild( sph1 );
			scene.addChild( sph2 );
			scene.addChild( light );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			sph1.rotateY(0.2);
			sph1.rotateX(0.1);
		}
		
	}

}