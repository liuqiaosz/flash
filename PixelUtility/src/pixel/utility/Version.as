package pixel.utility
{
	public class Version
	{
		private var _major:int = 0;
		public function get major():int
		{
			return _major;
		}
		private var _minor:int = 0;
		public function get minor():int
		{
			return _minor;
		}
		public function Version(major:int = 0,minor:int = 0)
		{
			_major = major;
			_minor = minor;
		}
	}
}