package pixel.core
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import pixel.codec.spr.ISpriteSheet;
	import pixel.codec.spr.SpriteSheetFrame;

	/**
	 * 位图序列精灵
	 * 
	 * 
	 **/
	public class PixelSpriteSheet extends PixelSprite implements IPixelSpriteSheet
	{
		private var _sheet:ISpriteSheet = null;
		private var _frame:SpriteSheetFrame = null;
		public function PixelSpriteSheet(sheet:ISpriteSheet)
		{
			super();
			_sheet = sheet;
			//默认第一帧
			_frame = _sheet.GetFrameByIndex(0);
			draw(_frame.Bitmap);
		}
		
		public function get imageSheet():Vector.<SpriteSheetFrame>
		{
			return _sheet.Frames;
		}
		
		/**
		 * 返回当前播放的序列帧
		 * 
		 * 
		 **/
		override public function get image():BitmapData
		{
			return _frame.Bitmap;
		}
		
		protected var _lastUpdate:int = 0;
		/**
		 * 更新帧状态
		 * 
		 * 
		 **/
		override public function update():void
		{
			var timer:int = flash.utils.getTimer();
			if((timer - _lastUpdate) >= _sheet.Delay)
			{
				_lastUpdate = timer;
				_frame = _sheet.NextFrame();
			}
			
			//绘制
			draw(_frame.Bitmap);
		}
	}
}