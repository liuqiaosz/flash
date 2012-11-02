package game.sdk.net
{
	import flash.utils.Dictionary;

	/**
	 * HTTP参数对象
	 **/
	public class HttpAttribute extends Dictionary implements IAttribute
	{
		public function HttpAttribute()
		{
		}
		
		public function GetPakcage():*
		{
			var Package:String = "";
			
			for(var Key:* in this)
			{
				Package += Key + "=" + this[Key] + "&";
			}
			return Package;
		}
	}
}