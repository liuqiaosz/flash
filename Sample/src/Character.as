package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	import game.sdk.spr.SpriteSheet;
	import game.sdk.spr.SpriteSheetFrame;

	public class Character extends Sprite
	{
		private var action:SpriteSheet = null;
		private var play:Boolean = false;
		private var img:Bitmap = null;
		public function Character()
		{
			img = new Bitmap();
			addChild(img);
		}
		
		public function playAction(act:SpriteSheet):void
		{
			if(!play)
			{
				action = act;
				play = true;
			}
		}
		
		private var _time:uint = 0;
		public function update():void
		{
			if(play && action)
			{
				var now:uint = flash.utils.getTimer();
				if(now - _time > action.Delay)
				{
					var frame:SpriteSheetFrame = action.NextFrame();
					img.bitmapData = frame.Bitmap;
					
					if(action.Position + 1 >= action.FrameCount)
					{
						play = false;
					}
				}
			}
		}
	}
}