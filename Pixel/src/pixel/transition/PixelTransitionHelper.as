package pixel.transition
{
	import flash.display.Sprite;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNs;

	use namespace PixelNs;
	/**
	 * 过渡效果工具类
	 * 
	 * 
	 **/
	public class PixelTransitionHelper
	{
		public function PixelTransitionHelper()
		{
		}
		
		public static function transition(type:int,transOut:Object,transIn:Object,duration:Number):PixelTransitionSquare
		{
			switch(type)
			{
				case PixelTransitionContants.FLIPX_LEFT:
					var queue:Array = [];
					var param:PixelTransitionVars = null;
					var flip:PixelTransitionFlipX = null;
					
					if(transOut)
					{
						//当前场景往左滑出主屏幕
						param = new PixelTransitionVars(transOut,duration);
						param.x = PixelLauncher.launcher.screen.screenWidth * -1;
						param.y = PixelLauncher.launcher.screen.screenHeight * -1;
						flip = new PixelTransitionFlipX(param);
						queue.push(flip);
					}
					
					if(transIn)
					{
						//激活场景从屏幕右边划入主屏幕
						param = new PixelTransitionVars(transIn,duration);
						//设置激活场景的坐标为右边屏幕
						transIn.x = PixelLauncher.launcher.screen.screenWidth;
						//_switchScene.y = PixelLauncher.launcher.screen.screenHeight;
						//设定目标为屏幕左上角
						param.x = 0;
						param.y = 0;
						
						flip = new PixelTransitionFlipX(param);
						queue.push(flip);
					}
					
					if(queue.length == 0)
					{
						break;
					}
					//批处理
					var square:PixelTransitionSquare = new PixelTransitionSquare(queue);
					//square.addEventListener(PixelTransitionEvent.TRANS_SQUARE_COMPLETE,switchTransitionComplete);
					return square;
					break;
			}
			return null;
		}
	}
}