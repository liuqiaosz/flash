package bleach.utils
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;

	public class ShareObjectHelper
	{
		private static var _cache:Dictionary = new Dictionary();
		public function ShareObjectHelper()
		{
		}
		
		public static function findShareDisk(name:String):ShareDisk
		{
			if(!(name in _cache))
			{
				var so:SharedObject = SharedObject.getLocal(name);
				_cache[name] = new ShareDisk(so);
			}
			return _cache[name];
		}
	}
}