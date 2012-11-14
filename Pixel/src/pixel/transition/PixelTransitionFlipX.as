package pixel.transition
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import pixel.core.PixelLauncher;
	import pixel.message.PixelMessage;
	import pixel.message.PixelMessage;
	import pixel.transition.event.PixelTransitionEvent;

	/**
	 * 水平翻动过渡效果实现
	 * 
	 * 
	 **/
	public class PixelTransitionFlipX extends PixelTransition
	{
		private var startX:int = 0;
		private var destX:int = 0;
		private var distance:int = 0;		//移动距离
		private var frameCount:int = 0;	//帧总数
		private var frameValue:Number = 0;	//每帧移动数量
		private var frameUpdated:int = 0;
		private var target:Sprite = null;

		public function PixelTransitionFlipX(param:PixelTransitionVars)
		{
			super(param);
		}
		
		override public function begin():void
		{
			target = _vars.target as Sprite;
			//作用对象当前坐标
			startX = _vars.target.x;
			//作用对象目标坐标
			destX = _vars.x;
			//计算移动距离
			distance = destX - startX;
			//根据时间计算帧数,帧移动值
			frameCount = (_vars.duration * 1000 / PixelLauncher.frameRate);
			frameValue = distance / frameCount;
			//注册帧更新
			register(PixelMessage.FRAME_UPDATE,update);
		}
		
		private function update(message:pixel.message.PixelMessage):void
		{
			if(frameUpdated == frameCount)
			{
				//设置目标坐标，修正小数偏差
				target.x = destX;
				//效果运行完毕
				this.unRegister(PixelMessage.FRAME_UPDATE,update);
				this.dispatchEvent(new PixelTransitionEvent(PixelTransitionEvent.TRANS_COMPLETE));
				return;
			}
			frameUpdated++;
			target.x += frameValue;
		}
	}
}