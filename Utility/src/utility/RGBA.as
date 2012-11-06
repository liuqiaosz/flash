package utility
{
	public class RGBA
	{
		public var Red:uint = 0;
		public var Green:uint = 0;
		public var Blue:uint = 0;
		public var Alpha:uint = 1;
		
		public function RGBA(R:uint=0,G:uint=0,B:uint = 0,A:uint = 0)
		{
			Red = R;
			Green = G;
			Blue = B;
			Alpha = A;
		}
		
		public function get Pixel():uint
		{
			return Alpha << 24 | Red << 16 | Green << 8 | Blue;
		}
	}
}