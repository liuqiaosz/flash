package pixel.utility.bitmap.tga
{
	public class TGADescription
	{
		private var _Desc:int = 0;
		public function TGADescription(Value:int)
		{
			_Desc = Value;
		}
		
		public function get Bit():int
		{
			return _Desc & 15;
		}
		
		public function get ScreenStart():int
		{
			return _Desc >> 4 & 1;
		}
		public function get Flag():int
		{
			return _Desc >> 6 & 3;
		}
	}
}