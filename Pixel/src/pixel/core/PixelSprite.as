package pixel.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * Pixel精灵类
	 * 
	 * 用于
	 * 
	 * 
	 **/
	public class PixelSprite extends PixelNode implements IPixelSprite
	{
		private var _source:BitmapData = null;
		public function PixelSprite(source:BitmapData = null)
		{
			draw(source);
		}
		
		/**
		 * 返回当前精灵的位图
		 * 
		 **/
		public function get image():BitmapData
		{
			return _source;
		}
		
		private var _canvas:Bitmap = null;
		protected function draw(source:BitmapData):void
		{
			_source = source;
			if(!_canvas)
			{
				_canvas = new Bitmap();
				super.addChild(_canvas);
			}
			_canvas.bitmapData = _source;
		}
		
		/**
		 * 状态更新
		 * 
		 * 
		 **/
		override public function update():void
		{
		}
	}
}