package
{
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	import pixel.particle.IPixelParticleBase;
	import pixel.particle.PixelParticle;
	import pixel.particle.PixelParticleEmitter;
	import pixel.particle.PixelParticlePropertie;
	import pixel.utility.Tools;

	public class Emitter extends PixelParticleEmitter
	{
		public function Emitter(propertie:PixelParticlePropertie)
		{
			super(propertie);
		}
		
		override protected function particleUpdate(particle:IPixelParticleBase):void
		{
			particle.x += Math.cos(particle.redian) * _propertie.velocityX;
			particle.y += Math.sin(particle.redian) * _propertie.velocityY;
		}
		
		override protected function newParticle():IPixelParticleBase
		{
			var glow:GlowFilter = new GlowFilter(0x00FF00,0.5);
			var blur:BlurFilter = new BlurFilter(5,5,1);
			var radian:Number = Tools.degreesToRadius(Math.random() * 360);
			var particle:PixelParticle = new PixelParticle(_propertie.size,_propertie.color,redian);
			particle.filters = [glow,blur];
			return particle;
		}
	}
}