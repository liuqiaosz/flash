package bleach
{
	public class SceneLinkLibrary
	{
		private var _desc:String = "";
		public function set desc(value:String):void
		{
			_desc = value;
		}
		public function get desc():String
		{
			return _desc;
		}
		private var _id:String = "";
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		private var _version:String = "";
		public function set version(value:String):void
		{
			_version = value;
		}
		public function get version():String
		{
			return _version;
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
		
		private var _isUIlib:Boolean = false;
		public function set isUIlib(value:Boolean):void
		{
			_isUIlib = value;
		}
		public function get isUIlib():Boolean
		{
			return _isUIlib;
		}
		
		public function SceneLinkLibrary(id:String,version:String,url:String,desc:String)
		{
			_id = id;
			_version = version;
			_url = url;
			_desc = desc;
		}
	}
}