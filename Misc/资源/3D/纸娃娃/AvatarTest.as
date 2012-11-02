package
{
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.core.Label3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.loaders.Flare3DLoader;
	import flare.loaders.Flare3DLoader1;
	import flare.materials.filters.AlphaMaskFilter;
	import flare.modifiers.SkinModifier;
	import flare.system.Input3D;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width=1000,height=600)]
	public class AvatarTest extends Sprite
	{
		[Embed(source="../model/03.f3d",mimeType="application/octet-stream")]
		private var MClass3:Class;
		
		[Embed(source="../model/04.f3d",mimeType="application/octet-stream")]
		private var MClass4:Class;
		
		[Embed(source="../model/act.f3d",mimeType="application/octet-stream")]
		private var RunClass:Class;
		
		private var scene:Scene3D;
		private var run:Pivot3D;
		private var avatar:Pivot3D;
		private var avatar2:Pivot3D;
		
		private var oldMesh:Mesh3D;
		private var newMesh:Mesh3D
		public function AvatarTest()
		{
			scene=new Viewer3D(this);
			
			scene.camera=new Camera3D();
			scene.registerClass(Flare3DLoader1);
			scene.camera.z=200;
			scene.camera.y=100;
			scene.camera.lookAt(0,0,-200);
			scene.registerClass(AlphaMaskFilter);
			avatar=scene.addChildFromFile(new MClass3);
			
			run=new Flare3DLoader(new RunClass);
			avatar2=scene.addChildFromFile(new MClass4);
			avatar2.x=100;
			scene.removeChild(avatar2);
			
			scene.library.push(run as Flare3DLoader);
			//scene.library.push(avatar2 as Flare3DLoader);
			scene.pause();
			
			scene.addEventListener(Scene3D.COMPLETE_EVENT,onCom);
		}
		
		protected function onCom(e:Event):void
		{
			Pivot3DUtils.appendAnimation(avatar,run,"run");
			scene.resume();
			scene.addEventListener(Scene3D.UPDATE_EVENT,onUpdate);
		}
		
		protected function onUpdate(e:Event):void
		{
			if(Input3D.keyUp(Input3D.NUMBER_1))
			{
				oldMesh=avatar.getChildByName("Boots") as Mesh3D;	
				newMesh=avatar2.getChildByName("Boots").clone() as Mesh3D;
				//newMesh.copyTransformFrom(oldMesh);
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
			}
			
			if(Input3D.keyUp(Input3D.NUMBER_2))
			{
				oldMesh=avatar.getChildByName("Leg") as Mesh3D;	
				newMesh=avatar2.getChildByName("Leg").clone() as Mesh3D;
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
			}
			if(Input3D.keyUp(Input3D.NUMBER_3))
			{
				oldMesh=avatar.getChildByName("Body") as Mesh3D;	
				newMesh=avatar2.getChildByName("Body").clone() as Mesh3D;
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
			}
			if(Input3D.keyUp(Input3D.NUMBER_4))
			{
				oldMesh=avatar.getChildByName("Glove_R") as Mesh3D;	
				newMesh=avatar2.getChildByName("Glove_R").clone() as Mesh3D;
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
				oldMesh=avatar.getChildByName("Glove_L") as Mesh3D;	
				newMesh=avatar2.getChildByName("Glove_L").clone() as Mesh3D;
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
			}
			if(Input3D.keyUp(Input3D.NUMBER_5))
			{
				oldMesh=avatar.getChildByName("Helmet") as Mesh3D;	
				newMesh=avatar2.getChildByName("Helmet").clone() as Mesh3D;
				newMesh.modifier=oldMesh.modifier;
				avatar.removeChild(oldMesh);
				avatar.addChild(newMesh);
			}
			
		}
	}
}