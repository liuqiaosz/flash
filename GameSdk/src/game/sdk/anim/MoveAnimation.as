package game.sdk.anim
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	/**
	 * UI库移动动画
	 **/
	public class MoveAnimation extends AnimationObject
	{
		public function MoveAnimation(component:Object)
		{
			super(component);
		}
		
		private var _destX:Number = 0;
		private var _destY:Number = 0;
		
		private var _openElastic:Boolean = false;
		public function enableElastic():void
		{
			_openElastic = true;
		}
		public function disableElastic():void
		{
			_openElastic = false;
		}
		/**
		 * 设置目的坐标
		 **/
		public function toPosition(posX:Number,posY:Number):void
		{
			_destY = posY;
			_destX = posX;
		}
		
		/**
		 * 开始动画
		 **/
		override public function start():void
		{
			if(!token)
			{
				if(_openElastic)
				{
					TweenLite.to(_component,duration,{x:_destX,y:_destY,ease:Elastic.easeOut,onComplete:OnComplete});
				}
				else
				{
					TweenLite.to(_component,duration,{x:_destX,y:_destY,onComplete:OnComplete});
				}
				super.start();
			}
		}
		/**
		 * 恢复animation
		 **/
		override public function restore():void
		{
			if(token)
			{
				if(_openElastic)
				{
					TweenLite.to(_component,duration,{x:_orignalX,y:orignalY,ease:Elastic.easeOut,onComplete:_restoreCallback});
				}
				else
				{
					TweenLite.to(_component,duration,{x:_orignalX,y:orignalY,onComplete:_restoreCallback});
				}
				super.start();
			}
		}
	}
}