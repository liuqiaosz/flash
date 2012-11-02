package game.sdk.anim
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	
	
	public class TransformAnimation extends AnimationObject
	{
		public function TransformAnimation(component:Object)
		{
			super(component);
		}
		
		private var _reW:Number = _orignalW;
		private var _reH:Number = _orignalH;
		
//		public function resize(w:Number,h:Number):void
//		{
//			_reW = w;
//			_reH = h;
//		}
//		
//		//偏移量
//		private var _offsetX:Number = 0;
//		public function set offsetX(data:Number):void
//		{
//			_offsetX = data;
//		}
//		private var _offsetY:Number = 0;
//		public function set offsetY(data:Number):void
//		{
//			_offsetY = data;
//		}
//		
//		private var _restoreW:Number = _orignalW;
//		public function set restoreWidth(data:Number):void
//		{
//			_restoreW = data;
//		}
//		private var _restoreH:Number = _orignalH;
//		public function set restoreHeight(data:Number):void
//		{
//			_restoreH = data;
//		}
//		private var _restoreX:Number;
//		private var _restoreY:Number;
		
		
		private var _startParam:Object = null;
		public function set startParam(param:Object):void
		{
			_startParam = param;
		}
		private var _restoreParam:Object = null;
		public function set restoreParam(param:Object):void
		{
			_restoreParam = param;
		}
		
		/**
		 * 开始动画
		 **/
		override public function start():void
		{
//			_restoreW = _component.width;
//			_restoreH = _component.height;
//			_restoreX = _orignalX;
//			_restoreY = _orignalY;
			TweenLite.to(_component,duration,_startParam);
			//TweenLite.to(_component,duration,{width:_reW,height:_reH,x:_orignalX + _offsetX,y:_orignalY + _offsetY,ease:Elastic.easeOut,onComplete:_startCallback});
			super.start();
		}
		/**
		 * 恢复animation
		 **/
		override public function restore():void
		{
			//trace("restore Y[" + _restoreY + "]");
			TweenLite.to(_component,duration,_restoreParam);
			//TweenLite.to(_component,duration,{width:_restoreW,height:_restoreH,x:_restoreX,y:_restoreY,ease:Expo.easeOut,onComplete:_restoreCallback});
			super.restore();
		}
	}
}