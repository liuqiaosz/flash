package game.sdk.anim
{
	import flash.events.EventDispatcher;
	
	import game.sdk.anim.event.AnimationEvent;

//	import fl.transitions.Tween;
	
	public class AnimationObject extends EventDispatcher implements IAnimation
	{
		private var _token:Boolean = false;
		public function get token():Boolean
		{
			return _token;
		}
		
		public var _component:Object = null;
		protected var _orignalX:Number;
		public function get orignalX():Number
		{
			return _orignalX;
		}
		protected var _orignalY:Number;
		public function get orignalY():Number
		{
			return _orignalY;
		}
		protected var _orignalW:Number;
		protected var _orignalH:Number;
		
		public function AnimationObject(component:Object)
		{
			_component = component;
			_orignalX = _component.x;
			_orignalY = _component.y;
			_orignalW = _component.width;
			_orignalH = _component.height;
		}
		
		public function OnComplete():void
		{
			this.dispatchEvent(new AnimationEvent(AnimationEvent.PLAY_COMPLETE));
		}
		
		protected var _restoreCallback:Function = null;
		public function onRestoreComplete(callback:Function):void
		{
			_restoreCallback = callback;
		}
		
		/**
		 * 持续时间,单位秒
		 **/
		private var _duration:uint = 2;
		public function set duration(data:uint):void
		{
			_duration = data;
		}
		public function get duration():uint
		{
			return _duration;
		}
		
//		private var _tweenArray:Vector.<Tween> = new Vector.<Tween>();
//		public function addTween(tween:Tween):void
//		{
//			_tweenArray[_tweenArray.length] = tween;
//		}
//		protected function startQueue():void
//		{
//			var tween:Tween = null;
//			
//			while((tween = tweenArray.pop()) != null)
//			{
//				tween.start();
//			}
//		}
//		public function get tweenArray():Vector.<Tween>
//		{
//			return _tweenArray;
//		}
		public function start():void
		{
			_token = true
		}
		public function restore():void
		{
			_token = false;
		}
	}
}