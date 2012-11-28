package
{
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	import pixel.particle.IPixelParticleBase;
	import pixel.particle.PixelParticle;
	import pixel.particle.PixelParticleEmitter;
	import pixel.particle.PixelParticleEmitterPropertie;
	import pixel.utility.Tools;

	public class Emitter extends PixelParticleEmitter
	{
		public function Emitter(propertie:PixelParticleEmitterPropertie)
		{
			super(propertie);
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawCircle(0,0,5);
			this.graphics.endFill();
		}
		
		override protected function particleUpdate(particle:IPixelParticleBase):void
		{
			//particle.x += Math.cos(particle.redian) * _propertie.velocityX;
			//particle.y += Math.sin(particle.redian) * _propertie.velocityY;
			particle.update();
			//particle.y += _propertie.gravity;
		}
		
		override protected function newParticle():IPixelParticleBase
		{
			var glow:GlowFilter = new GlowFilter(0x5d5d5d,1);
			var blur:BlurFilter = new BlurFilter(6,6,2);
			//var radian:Number = Tools.degreesToRadius(Math.random() * 360);
			//var radian:Number = Tools.degreesToRadius(315);
			var particle:PixelParticlePlus = new PixelParticlePlus(_propertie);
			particle.filters = [glow,blur];
			return particle;
		}
	}
}
import pixel.particle.PixelParticle;
import pixel.particle.PixelParticlePropertie;

class PixelParticlePlus extends PixelParticle
{
	public function PixelParticlePlus(propertie:PixelParticlePropertie)
	{
		super(propertie);
	}
	private var _vy:Number = 1;
	override public function update():void
	{
		x = Math.cos(_radian) * _velocityX;
		y = Math.sin(_radian) * _velocityY;
		y += _vy;
		_vy -= 2;
		super.update();
		_radian += _propertie.radianAttenuation;
		//alpha = _health / _propertie.health;
		//this.invalidatePropertie();
		//alpha -= 0.02;
//		if(_velocityX > 0)
//		{
//			_velocityX += _accelerationX;
//		}
//		else
//		{
//			_accelerationX = 1;
//			_velocityY += _accelerationY;
//			trace(_velocityY);
//			//y+= _velocityY;
//		}
	}
}

class PixelParticlePlus2 extends PixelParticle
{
	public function PixelParticlePlus2(propertie:PixelParticlePropertie)
	{
		super(propertie);
	}
	private var _vy:Number = 1;
	override public function update():void
	{
		//x = Math.cos(_radian) * _velocityX;
		//y = Math.sin(_radian) * _velocityY + _vy;
		
		//_vy -= 2;
		y -= 10;
		//alpha = _health / _propertie.health;
		//_radian += _propertie.radianAttenuation;
		super.update();
	}
}