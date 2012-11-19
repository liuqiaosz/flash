package pixel.ui.control.effect
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;

	public class Effect implements IEffect
	{
//		private static var _PluginInited:Boolean = false;
//		private var _Duration:Number = 0;
//		public function set Duration(Value:Number):void
//		{
//			_Duration = Value;
//		}
//		public function get Duration():Number
//		{
//			return _Duration;
//		}
//		private var _Yoyo:Boolean = false;
//		public function set Yoyo(Value:Boolean):void
//		{
//			_Yoyo = Value;
//			if(_Yoyo && _Repeat < 0)
//			{
//				//_Repeat = 1;
//			}
//		}
//		private var _Repeat:int = 1;
//		public function set Repeat(Value:int):void
//		{
//			_Repeat = Value;
//			
//			if(_Repeat < 0)
//			{
//				_Yoyo = false;
//			}
//		}
//		private var _Filter:IEffectFilter = null;
//		public function set Filter(Value:IEffectFilter):void
//		{
//			_Filter = Value;
//		}
//		
//		private var _RepeatDelay:Number = 0;
//		public function set RepeatDelay(Value:Number):void
//		{
//			_RepeatDelay = Value;
//		}
//		private var _Ease:int = EaseMode.EASE_EXPO_OUT;
//		public function set Ease(Value:int):void
//		{
//			_Ease = Value;
//		}
		
		protected var _Source:Object = null;
		public function Effect(Source:Object)
		{
			_Source = Source;
		}
		
		public function BuildParams():Object
		{
//			var Param:Object = {
//				ease: GetEase(),
//				yoyo: _Yoyo,
//				repeat: _Repeat,
//				repeatDelay: _RepeatDelay
//			};
//			if(_Filter is EffectBlurFilter)
//			{
//				Param.blurFilter = _Filter.Param;
//			}
//			else
//			{
//				Param.glowFilter = _Filter.Param;
//			}
//			return Param;
			return null;
		}
		
		public function Play():void
		{
//			if(_Repeat < 0)
//			{
//				TweenMax.to(_Source,_Duration,BuildParams());
//			}
//			else
//			{
//				if(!_PluginInited)
//				{
//					TweenPlugin.activate([BlurFilterPlugin,GlowFilterPlugin]);
//					_PluginInited = true;
//				}
//				TweenLite.to(_Source,_Duration,BuildParams());
//			}
		}
		
//		protected function GetEase():Function
//		{
//			switch(_Ease)
//			{
//				case EaseMode.EASE_BACK_IN:
//					return Back.easeIn;
//					break;
//				case EaseMode.EASE_BACK_OUT:
//					return Back.easeOut;
//					break;
//				case EaseMode.EASE_BOUNCE_IN:
//					return Bounce.easeIn;
//					break;
//				case EaseMode.EASE_BOUNCE_OUT:
//					return Bounce.easeOut;
//					break;
//				case EaseMode.EASE_CIRC_IN:
//					return Circ.easeIn;
//					break;
//				case EaseMode.EASE_CIRC_OUT:
//					return Circ.easeOut;
//					break;
//				case EaseMode.EASE_ELASTIC_IN:
//					return Elastic.easeIn;
//					break;
//				case EaseMode.EASE_ELASTIC_OUT:
//					return Elastic.easeOut;
//					break;
//				case EaseMode.EASE_EXPO_IN:
//					return Expo.easeIn;
//					break;
//				case EaseMode.EASE_EXPO_OUT:
//					return Expo.easeOut;
//					break;
//			}
//			return null;
//		}
	}
}