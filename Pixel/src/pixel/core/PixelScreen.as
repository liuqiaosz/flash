package pixel.core
{
	use namespace PixelNs;
	
	public class PixelScreen
	{
		private var _screenWidth:int = 0;
		public function set screenWidth(value:int):void
		{
			_screenWidth = value;
		}
		public function get screenWidth():int
		{
			return _screenWidth;
		}
		
		private var _screenHeight:int = 0;
		public function set screenHeight(value:int):void
		{
			_screenHeight = value;
		}
		public function get screenHeight():int
		{
			return _screenHeight;
		}
		
		public function PixelScreen()
		{
		}
	}
}