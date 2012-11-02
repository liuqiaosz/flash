package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flash.display.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Mixamo Collada models test.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test16_Mixamo_Collada_Models extends Sprite 
	{
		private var scene:Scene3D;
		private var model:Pivot3D;
		
		public function Test16_Mixamo_Collada_Models() 
		{
			// creates the scene.
			scene = new Viewer3D(this);
			scene.camera.setPosition( 200, 200, -300 );
			scene.camera.lookAt( 0, 50, 0 );
			
			model = scene.addChildFromFile( "../resources/walking_1.dae", null, ColladaLoader );
			
			//model = scene.addChildFromFile( "../resources/howl_1.dae", null, ColladaLoader );
			
			//model = scene.addChildFromFile( "../resources/knocked_out_7.dae", null, ColladaLoader );
			
			//model = scene.addChildFromFile( "../resources/aerial_dragon_attack_2.dae", null, ColladaLoader );
			//model.setScale( 0.25, 0.25, 0.25 );
			//model.setPosition( 0, -100, 0 )
		}
	}
}