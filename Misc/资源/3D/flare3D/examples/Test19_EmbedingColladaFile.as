package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flash.display.*;
	import flash.display3D.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Mixamo Collada models test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test19_EmbedingColladaFile extends Sprite 
	{
		[Embed(source='../resources/knocked_out_7.dae', mimeType='application/octet-stream')]
		private static var DAEFile:Class;
		
		[Embed(source = '../resources/textures/Soldier_new-1.jpg')]
		private static var TextureFile:Class;
		
		private var scene:Scene3D;
		
		public function Test19_EmbedingColladaFile() 
		{
			// creates the scene.
			scene = new Viewer3D(this);
			scene.camera.setPosition( 200, 200, -300 );
			scene.camera.lookAt( 0, 50, 0 );
			
			/* method 1 - embed collada but keep the textures external. */
			
			//var collada:ColladaLoader = new ColladaLoader( XML(new DAEFile), null, scene, "../resources/", false, Context3DTriangleFace.BACK );
			//collada.parent = scene;
			//collada.load();
			
			/* method 2 - embed collada and textures. we need to add the texture to the library manually. */
			
			//scene.library.addItem( "textures/Soldier_new-1.jpg", new Texture3D( new TextureFile ) );			
			//var collada:ColladaLoader = new ColladaLoader( XML(new DAEFile) );
			//collada.parent = scene;
			//collada.load();
			
			/* method 3 - embeded collada, keep the textures external, and use the global scene events. */
			
			var collada:ColladaLoader = new ColladaLoader( XML(new DAEFile), null, scene, "../resources/", false, Context3DTriangleFace.BACK );
			scene.addChild( collada );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			scene.library.push( collada );z
		}
		
		private function completeEvent(e:Event):void 
		{
			trace("loaded")
		}
	}
}