package  
{
	import base.*;
	import components.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.primitives.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * How to attach a bone controller to an object.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test23_BoneController extends Base 
	{
		private var scene:Scene3D;
		private var model:Pivot3D;
		
		public function Test23_BoneController() 
		{
			super( "Bones - How to attach a bone controller to an object.\n" );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Viewer3D( this );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			model = scene.addChildFromFile( "../resources/player.f3d" );
		}
		
		private function completeEvent(e:Event):void 
		{
			// this could besomething strange, but it has the reason to be ;)
			// we can not parent an object directly to a bone because the bones are not in the scene.
			// in fact, the skeletons are just an instance of a virtual skeleton.
			// it means, you could have a bunch of skinned meshes instances, and all will share the same skeleton.
			// so, a good way to attach an object to a bone could be a bone controller component like the followin code.
			
			var skinnedMesh:Mesh3D = model.getChildByName( "PlayerFutbol" ) as Mesh3D;
			
			var hand1:Cube = new Cube( "hand1", 0.1, 0.1, 0.1 );
			var hand2:Cube = new Cube( "hand2", 0.1, 0.1, 0.1 );
			var hat:Cube = new Cube( "hat", 0.4, 0.04, 0.4 );
			
			// rotates the hat, because the bone head has different orientation.
			hat.rotateZ(90);
			
			hand1.addComponent( new BoneController( skinnedMesh, "BipPlayerFutbol R Hand" ) );
			hand2.addComponent( new BoneController( skinnedMesh, "BipPlayerFutbol L Hand" ) );
			hat.addComponent( new BoneController( skinnedMesh, "BipPlayerFutbol HeadNub" ) );
			
			scene.addChild( hand1 );
			scene.addChild( hand2 );
			scene.addChild( hat );
		}
	}
}