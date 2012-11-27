package pixel.particle
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	/**
	 * 粒子发射器
	 */
	public class PixelParticleEmitter extends Sprite implements IPixelParticleEmitter
	{
		//全部粒子队列
		protected var _totalPool:Vector.<IPixelParticleBase> = null;
		//粒子回收池
		protected var _reCyclePool:Vector.<IPixelParticleBase> = null;
		//活动粒子队列
		protected var _activePool:Vector.<IPixelParticleBase> = null;
		protected var _propertie:PixelParticlePropertie = null;
		
		public function PixelParticleEmitter(propertie:PixelParticlePropertie)
		{
			_propertie = propertie;
			if(_propertie.poolable)
			{
				_reCyclePool = new Vector.<IPixelParticleBase>();
				_activePool = new Vector.<IPixelParticleBase>();
			}
		}
		
		protected var _lastFire:int = 0;
		protected var _time:int = 0;
		private var _particle:IPixelParticleBase;
		/**
		 * 更新发射器状态
		 */
		public function update():void
		{
			_time = flash.utils.getTimer();
			if(_time - _lastFire >= _propertie.emitterLazy)
			{
				fireParticle();
			}
			
			for each(_particle in _activePool)
			{
				_particle.update();
			}
		}
		
		protected function fireParticle():void
		{
			
		}
		
		protected function particleLogic(particle:IPixelParticleBase):void
		{
			
		}
		
		public function reset():void
		{}
	}
}