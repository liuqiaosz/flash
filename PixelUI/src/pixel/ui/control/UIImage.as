package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import pixel.ui.control.style.ImageStyle;
	import pixel.ui.control.style.UIImageStyle;
	import pixel.utility.bitmap.gif.GIFDecoder;
	import pixel.utility.bitmap.gif.GIFFrame;

	public class UIImage extends UIControl
	{
		private var _gifFrames:Vector.<GIFFrame> = new Vector.<GIFFrame>();
		private var _timer:Timer = null;
		private var _currentIndex:int = 0;
		private var _count:int = 0;
		public function UIImage(Skin:Class = null)
		{
			super(Skin?Skin:UIImageStyle);
			width = 48;
			height = 48;
		}
		
		/**
		 * 设置样式
		 * 
		 * 
		 **/
		public function set gif(value:ByteArray):void
		{
			UIImageStyle(Style).gif = value;
			if(value)
			{
				
				var decoder:GIFDecoder = new GIFDecoder();
				var result:int = decoder.read(value);
				if(result == 0)
				{
					_gifFrames.length = 0;
					_count = decoder.getFrameCount();
					for(var idx:int = 0; idx<_count; idx++)
					{
						_gifFrames.push(decoder.getFrame(idx));	
					}
				}
				
				if(_timer)
				{
					if(_timer.running)
					{
						_currentIndex = 0;
					}
				}
				else
				{
					_timer = new Timer(decoder.getDelay(0));
					_timer.addEventListener(TimerEvent.TIMER,playFrame);
					_timer.start();
				}
				img = decoder.getImage().bitmapData;
				_image.bitmapData = img;
				this.BackgroundImage = _image;
			}
		}
		
		private var _image:Bitmap = new Bitmap();
		private var img:BitmapData = null;
		protected function playFrame(event:TimerEvent):void
		{
			//this.BackgroundImage = new Bitmap(_gifFrames[_currentIndex].bitmapData);
			_image.bitmapData = _gifFrames[_currentIndex].bitmapData;
			//this.BackgroundImage = image;
			StyleUpdate();
			_currentIndex++;
			if(_currentIndex >= _count)
			{
				_currentIndex = 0;
			}
		}
		
		override public function dispose():void
		{
			if(_timer)
			{
				if(_timer.running)
				{
					_timer.stop();
					
				}
				_timer.removeEventListener(TimerEvent.TIMER,playFrame);
				_timer = null;
			}
		}
		
		public function set image(value:Bitmap):void
		{
			_image = super.BackgroundImage = value;
			width = value.width;
			height = value.height;
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			super.SpecialDecode(Data);
			if(UIImageStyle(Style).isGif)
			{
				gif = UIImageStyle(Style).gif;
			}
		}
	}
}