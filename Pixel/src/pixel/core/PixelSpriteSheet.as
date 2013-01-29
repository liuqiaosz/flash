package pixel.core
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import pixel.codec.spr.ISpriteSheet;
	import pixel.codec.spr.SpriteSheetFrame;
	import pixel.texture.vo.PixelTexture;
	import pixel.texture.vo.PixelTexturePackage;

	/**
	 * 位图序列精灵
	 * 
	 * 
	 **/
	public class PixelSpriteSheet extends PixelSprite implements IPixelSpriteSheet
	{
//		private var _sheet:ISpriteSheet = null;
//		private var _frame:SpriteSheetFrame = null;
//		public function PixelSpriteSheet(sheet:ISpriteSheet)
//		{
//			super();
//			_sheet = sheet;
//			//默认第一帧
//			_frame = _sheet.GetFrameByIndex(0);
//			image = _frame.Bitmap;
//		}
		private var _frameIdx:int = 0;
		private var _frameTexture:PixelTexture = null;
		private var _package:PixelTexturePackage = null;
		public function PixelSpriteSheet(pack:PixelTexturePackage)
		{
			_package = pack;
			_frameTexture = _package.textures[0];
		}
		
		/**
		 * 返回当前播放的序列帧
		 * 
		 * 
		 **/
		override public function get image():BitmapData
		{
			return _frameTexture.bitmap;
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
			if((timer - _lastUpdate) >= _package.playGap)
			{
				_lastUpdate = timer;
				_frameTexture = _package.textures[_frameIdx];
				_frameIdx++;
				if(_frameIdx >= _package.textures.length)
				{
					_frameIdx = 0;
				}
			}
			//绘制
			image = _frameTexture.bitmap;
		}
		
		public function get frame():PixelTexture
		{
			return _frameTexture;
		}
		
		override public function dispose():void
		{
			
		}
		
	}
}