package corecom.control.effect
{
	public class EffectGlowFilter implements IEffectFilter
	{
		private var _Color:uint = 0xFFFFFF;
		public function set Color(Value:uint):void
		{
			_Color = Value;
		}
		private var _Alpha:Number = 1;
		public function set Alpha(Value:Number):void
		{
			_Alpha = Value;
		}
		private var _BlurX:int = 0;
		public function set BlurX(Value:int):void
		{
			_BlurX = Value;
		}
		private var _BlurY:int = 0;
		public function set BlurY(Value:int):void
		{
			_BlurY = Value;
		}
		
		public function EffectGlowFilter()
		{
		}
		
		public function get Param():Object
		{
			return {
				color : _Color,
				alpha : _Alpha,
				blurX : _BlurX,
				blurY : _BlurY
			};
		}
	}
}