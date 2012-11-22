package pixel.ui.control.asset
{
	public class Asset
	{
		private var _name:String = "";
		public function set name(value:String):void
		{
			_name = value;
		}
		public function get name():String
		{
			return _name;
		}
		
		public function Asset(name:String = "")
		{
			_name = name;
		}
	}
}