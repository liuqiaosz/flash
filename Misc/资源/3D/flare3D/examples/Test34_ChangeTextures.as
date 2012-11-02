package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	/**
	 * Change textures in realtime.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test34_ChangeTextures extends Base 
	{
		private var scene:Scene3D;
		private var preLoadedTexture0:Texture3D;
		private var preLoadedTexture1:Texture3D;
		private var preLoadedTexture2:Texture3D;
		private var shader:Shader3D;
		
		public function Test34_ChangeTextures() 
		{
			scene = new Viewer3D(this);
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.addChildFromFile( "../resources/elsa.f3d" );
			
			preLoadedTexture0 = scene.addTextureFromFile( "../resources/terrain.png" );
			preLoadedTexture1 = scene.addTextureFromFile( "../resources/tree.png" );
			preLoadedTexture2 = scene.addTextureFromFile( "../resources/normal5.png" );
		}
		
		private function completeEvent(e:Event):void 
		{
			shader = scene.getMaterialByName( "mElsa" ) as Shader3D;
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// in this case, the first filter on the shader is a TextureFilter.
			
			// using this method, te texture will be loaded here, so the mesh will dissapear until the new texture is loaded.
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) shader.filters[0].texture = new Texture3D( "../resources/metal.jpg" );
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) shader.filters[0].texture = new Texture3D( "../resources/r42.jpg" );
			if ( Input3D.keyHit( Input3D.NUMBER_3 ) ) shader.filters[0].texture = new Texture3D( "../resources/reflections.jpg" );
			if ( Input3D.keyHit( Input3D.NUMBER_4 ) ) shader.filters[0].texture = new Texture3D( "../resources/gorda.png" );
			
			// using preloaded textures, the result will be immediately.
			if ( Input3D.keyHit( Input3D.NUMBER_5 ) ) shader.filters[0].texture = preLoadedTexture0;
			if ( Input3D.keyHit( Input3D.NUMBER_6 ) ) shader.filters[0].texture = preLoadedTexture1;
			if ( Input3D.keyHit( Input3D.NUMBER_7 ) ) shader.filters[0].texture = preLoadedTexture2;
		}
	}
}