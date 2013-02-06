package bleach.cfg
{
	import flash.utils.Dictionary;

	public class BleachErrorCode
	{
		private static var _dictionary:Dictionary = new Dictionary();
		public function BleachErrorCode()
		{
		}
		
		public static function getDescByCode(code:int):String
		{
			if(code in _dictionary)
			{
				return _dictionary[code] as String;
			}
			return "未定义错误";
		}
		
		public static function addErrorDesc(node:Object):void
		{
			var desc:String = node.@desc;
			_dictionary[int(node.@rescode)] = desc;	
		}
	}
}