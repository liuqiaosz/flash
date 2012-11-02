package game.sdk.anim
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;

	/**
	 * UI库缩放动画
	 **/
	public class ScaleAnimation extends AnimationObject
	{
		public static var POS_CENTER:uint = 0;
		public static var POS_LEFT:uint = 1;
		public static var POS_RIGHT:uint = 2;
		
		//缩放比率
		private var _scaleRate:Array = [1,1];
		public function set scaleRate(data:Array):void
		{
			_scaleRate = data;
		}
		
		public function ScaleAnimation(component:Object)
		{
			super(component);
		}
		
		/**
		 * 开启X缩放
		 **/
		private var _scaleX:Boolean = true;
		public function enableScaleX():void
		{
			_scaleX = true;
		}
		public function disableScaleX():void
		{
			_scaleX = false;
		}
		private var _scaleY:Boolean = true;
		/**
		 * 开启Y缩放
		 **/
		public function enableScaleY():void
		{
			_scaleY = true;
		}
		public function disableScaleY():void
		{
			_scaleY = false;
		}
		
		private var _position:uint = POS_LEFT;
		public function set position(data:uint):void
		{
			_position = data;
		}
		
		
		/**
		 * 
		 * 创建animation,并且启动
		 * 
		 **/
		override public function start():void
		{
			_component.scaleX = _scaleRate[0];
			_component.scaleY = _scaleRate[0];
			//var a:TweenLite
//			if(!token)
//			{
//				if(_scaleX)
//				{
//					addTween(new Tween(_component,"scaleX",Elastic.easeOut,_scaleRate[0],_scaleRate[1],duration,true));
//				}
//				if(_scaleY)
//				{
//					addTween(new Tween(_component,"scaleY",Elastic.easeOut,_scaleRate[0],_scaleRate[1],duration,true));
//				}
//				
//				if(position == POS_CENTER)
//				{
//					var n:uint = _component.realWidth * ((_scaleRate[1] - _scaleRate[0]) * .5);
//					trace("source[" + _component.x + "],target[" + (_component.x - n) + "]");
//					addTween(new Tween(_component,"x",Elastic.easeOut,_component.x,_component.x - n,duration,true));
//					//var tween3:Tween = new Tween(this,"x",Elastic.easeOut,this.x,(this.x - (width * .2)),2,true);
//				}
				var offset:Number = 0;
				
				if(_position == POS_CENTER)
				{
					offset = _component.realWidth * ((_scaleRate[1] - _scaleRate[0]) * .5);
				}
				
				TweenLite.to(_component,duration,{scaleX:_scaleRate[1],scaleY:_scaleRate[1],x:_component.x - offset,ease:Elastic.easeOut,onComplete:OnComplete});
				//startQueue();
				
				//super.start();
			//}
		}
		
		/**
		 * 恢复animation
		 **/
		override public function restore():void
		{
//			if(token)
//			{
//				if(_scaleX)
//				{
//					addTween(new Tween(_component,"scaleX",Elastic.easeOut,_scaleRate[1],_scaleRate[0],duration,true));
//				}
//				if(_scaleY)
//				{
//					addTween(new Tween(_component,"scaleY",Elastic.easeOut,_scaleRate[1],_scaleRate[0],duration,true));
//				}
//	
//				addTween(new Tween(_component,"x",Elastic.easeOut,_component.x,_orignalX,duration,true));
			
			TweenLite.to(_component,duration,{scaleX:_scaleRate[0],scaleY:_scaleRate[0],x:_orignalX,ease:Elastic.easeOut});
				
				//super.restore();
			//}
		}
		
		
	}
}