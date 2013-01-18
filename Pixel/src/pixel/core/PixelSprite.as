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
		public function PixelSprite(source:BitmapData = null)
		{
			image = source;
		}
		
		/**
		 * 返回当前精灵的位图
		 * 
		 **/
		public function get image():BitmapData
		{
			if(_canvas)
			{
				return _canvas.bitmapData;
			}
			return null;
		}
		
		private var _canvas:Bitmap = null;
		
		public function set image(value:BitmapData):void
		{
			if(value)
			{
				if(!_canvas)
				{
					_canvas = new Bitmap();
					this.addChild(_canvas);
				}
				_canvas.bitmapData = value;
			}
		}
		
		override public function dispose():void
		{
			if(_canvas)
			{
				super.removeChild(_canvas);
				if(_canvas.bitmapData)
				{
					_canvas.bitmapData.dispose();
				}
				_canvas = null;
			}
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