package pixel.utility
{
	import flash.net.SharedObject;

	public class ShareObjectHelper
	{
		public function ShareObjectHelper()
		{
		}
		
		public static function writerString(name:String,key:String,value:String):Boolean
		{
			try
			{
				var local:SharedObject = SharedObject.getLocal(name);
				local.data[key] = value;
				local.flush();
			}
			catch(err:Error)
			{
				return false;
			}
			return false;
		}
	}
}