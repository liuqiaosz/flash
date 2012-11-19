package pixel.assets
{
	public class AssetTask
	{
		private var _type:int = 0;
		public function set type(value:int):void
		{
			_type = value;
		}
		public function get type():int
		{
			return _type;
		}
		private var _url:String = "";
		public function set url(value:String):void
		{
			_url = value;
		}
		public function get url():String
		{
			return _url;
		}
		
		public function AssetTask(url:String = "",type:int = 0)
		{
			_url = url;
			_type = type;
		}
	}
}