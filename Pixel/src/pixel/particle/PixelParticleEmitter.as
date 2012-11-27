package pixel.particle
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	/**
	 * 粒子发射器
	 */
	public class PixelParticleEmitter extends Sprite implements IPixelParticleEmitter
	{
		protected var _death:Boolean = false;
		//发射器生命周期
		protected var _emitterHealth:Number = 0;
		//全部粒子队列
		protected var _totalPool:Vector.<IPixelParticleBase> = null;
		//粒子回收池
		protected var _reCyclePool:Vector.<IPixelParticleBase> = null;
		//活动粒子队列
		protected var _activePool:Vector.<IPixelParticleBase> = null;
		//交换队列
		protected var _swapPool:Vector.<IPixelParticleBase> = null;
		//粒子属性设置
		protected var _propertie:PixelParticlePropertie = null;
		
		protected var _particleSource:Class = null;
		
		public function PixelParticleEmitter(propertie:PixelParticlePropertie)
		{
			_propertie = propertie;
			if(_propertie.poolable)
			{
				_reCyclePool = new Vector.<IPixelParticleBase>();
				_activePool = new Vector.<IPixelParticleBase>();
				_swapPool = new Vector.<IPixelParticleBase>();
			}
		}
		
		protected var _lastFire:int = 0;
		protected var _time:int = 0;
		private var _particle:IPixelParticleBase;
		private var _particleAttenuation:Number = 0;
		private var _activeSwap:Vector.<IPixelParticleBase> = null;
		/**
		 * 更新发射器状态
		 */
		public function update():void
		{
			if(!_death)
			{
				_time = flash.utils.getTimer();
				if(_time - _lastFire >= _propertie.emitterLazy)
				{
					fireParticle();
				}
				
				for each(_particle in _activePool)
				{
					particleUpdate(_particle);
					//_particle.update();
					if(_particle.updateHealth(_particleAttenuation) > 0)
					{
						//放入交换池
						_swapPool.push(_particle);
					}
					else
					{
						if(_propertie.poolable)
						{
							//放入回收池
							_reCyclePool.push(_particle);
							if(contains(_particle as DisplayObject))
							{
								removeChild(_particle as DisplayObject);
							}
						}
					}
				}
				//保存原激活池
				_activeSwap = _activePool;
				//将激活池和交换池对换
				_activePool = _swapPool;
				//清空原激活池
				_activeSwap.length = 0;
				_swapPool = _activeSwap;
				//更新粒子发射器生命周期 
				updateHealth();
			}
			
		}
		
		protected function fireParticle():void
		{
			if(_propertie.maxmizeParticle > 0 && _totalPool.length >= _propertie.maxmizeParticle)
			{
				return;
			}
			
			var node:IPixelParticleBase = null;
			for(var idx:int = 0; idx<_propertie.particleCount; idx++)
			{
				if(_propertie.poolable && _reCyclePool.length > 0)
				{
					node = _reCyclePool.shift();
					node.reset();
				}
				else
				{
					node = newParticle();
					if(!node)
					{
						return;
					}
				}
				addChild(node as DisplayObject);
				
			}
		}
		
		protected function newParticle():IPixelParticleBase
		{
			return new PixelParticle(_propertie.size,_propertie.color,_propertie.health);
		}
		
		/**
		 * 粒子状态更新
		 * 
		 * 子类根据喷射类型更新粒子的位置，颜色等等属性
		 */
		protected function particleUpdate(particle:IPixelParticleBase):void
		{
			
		}
		
		public function get redian():Number
		{
			return 0;
		}
		
		/**
		 * 更新发射器生命周期
		 */
		public function updateHealth(attenuation:Number = 0):Number
		{
			if(!_death)
			{
				this._emitterHealth -= _propertie.emitterAttenuation;
				if(this._emitterHealth <= 0)
				{
					//dispatchEvent(new PixelParticleEvent(PixelParticleEvent.EMITTER_DEATH));
					_death = true;
				}
			}
			return _emitterHealth;
		}
		
		/**
		 * 状态复位
		 */
		public function reset():void
		{
			_death = false;
		}
		
		
		
		public function start():void
		{
			
		}
		public function pause():void
		{}
		public function stop():void
		{}
	}
}