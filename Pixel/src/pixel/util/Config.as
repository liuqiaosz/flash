package pixel.util
{
	public class Config
	{
		//一个消息队列的默认长度
		public static const MESSAGE_QUEUE_DEFAULTLENGTH:int = 10;
		private static var _assetFreezeTimeout:int = 20 * 60 * 1000;			//冻结超时为20分钟
		public static function set assetFreezeTimeout(value:int):void
		{
			_assetFreezeTimeout = value * 60 * 1000;
		}
		public static function get assetFreezeTimeout():int
		{
			return _assetFreezeTimeout;
		}
		
	}
}