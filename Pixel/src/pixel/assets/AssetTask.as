package pixel.assets
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
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
		
		private var _alias:String = "";
		public function set alias(value:String):void
		{
			_alias = value;
		}
		public function get alias():String
		{
			return _alias;
		}
		
		PixelNs var _info:Loader = null;
		PixelNs function set info(value:Loader):void
		{
			_info = value;
		}
		PixelNs function get info():Loader
		{
			return _info;
		}
		
		public function AssetTask(alias:String = "",url:String = "",type:int = 0)
		{
			_url = url;
			_type = type;
			_alias = alias;
		}
	}
}