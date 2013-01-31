package bleach
{
	public class SceneVO
	{
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
		
		public function SceneVO(id:String,version:String,url:String)
		{
			_id = id;
			_version = version;
			_url = url;
		}
		private var _librarys:Vector.<SceneLinkLibrary> = new Vector.<SceneLinkLibrary>();
		public function addLibrary(value:SceneLinkLibrary):void
		{
			_librarys.push(value);
		}
		
		public function get librarys():Vector.<SceneLinkLibrary>
		{
			return _librarys;
		}
	}
}