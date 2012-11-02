package
{
	import base.Base;
	
	import components.BoneController;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.core.Mesh3D;
	import flare.core.ParticleEmiter3D;
	import flare.core.Pivot3D;
	import flare.core.Texture3D;
	import flare.materials.ParticleMaterial3D;
	import flare.materials.filters.ColorParticleFilter;
	import flare.materials.filters.TextureFilter;
	
	import flash.display.Bitmap;
	import flash.events.Event;

	[SWF(width=800,height=600)]
	public class TheBao extends Base
	{
		[Embed(source="fire.png")]
		private var Fire:Class;
		
		[Embed(source="abao.f3d",mimeType="application/octet-stream")]
		private var ABao:Class;
		private var scene:Scene3D;
		private var bao:Pivot3D;
		public function TheBao(info:String="粒子绑定骨骼")
		{
			super(info);
			scene=new Viewer3D(this);
			scene.camera=new Camera3D();
			scene.camera.z=-250;
			scene.camera.y=100;
			//scene.frameRate=10;
			scene.addEventListener(Scene3D.COMPLETE_EVENT,onCom);
			
			bao=scene.addChildFromFile(new ABao);
			
		}
		private function onCom(e:Event):void
		{
			
			var fire:Bitmap=new Fire();
			var pm:ParticleMaterial3D=new ParticleMaterial3D();
			pm.filters.push(new TextureFilter(new Texture3D(fire.bitmapData)));
			pm.filters.push(new ColorParticleFilter([0xffffff,0xffff00,0xff0000,0x000000],[1,.5,.2,0]));
			pm.build();
			
			var fireEmiter:ParticleEmiter3D=new ParticleEmiter3D("",pm,new FireParticle());
			fireEmiter.particlesLife=20;
			fireEmiter.emitParticlesPerFrame=50;
			fireEmiter.rotateX(90);
			fireEmiter.layer=10;
			
			var fireEmiter2:ParticleEmiter3D=new ParticleEmiter3D("",pm,new FireParticle());
			fireEmiter2.particlesLife=20;
			fireEmiter2.emitParticlesPerFrame=50;
			fireEmiter2.rotateX(90);
			fireEmiter2.layer=11;
			
			var baoMesh:Mesh3D=bao.getChildByName("bao") as Mesh3D;
			fireEmiter.addComponent(new BoneController(baoMesh,"fire"));
			fireEmiter2.addComponent(new BoneController(baoMesh,"fire2"));
			scene.addChild(fireEmiter);
			scene.addChild(fireEmiter2);
		}
	}
}