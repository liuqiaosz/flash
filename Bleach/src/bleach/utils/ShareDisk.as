package bleach.utils
{
	import flash.net.SharedObject;

	public class ShareDisk
	{
		private var _source:SharedObject = null;
		public function ShareDisk(so:SharedObject)
		{
			_source = so;
		}
		
		public function addValue(key:String,value:Object):void
		{
			_source.data[key] = value;
			_source.flush();
		}
		public function getValue(key:String):Object
		{
			if(key in _source.data)
			{
				return _source.data[key];
			}
			return "";
		}
		
		public function clear():void
		{
			_source.clear();
		}
	}
}