package bleach.module.protocol
{
	/**
	 * 消息数据域
	 * 
	 **/
	public class ProtocolField
	{
		private var _key:String = "";
		public function set key(value:String):void
		{
			_key = value;
		}
		public function get key():String
		{
			return _key;
		}
		private var _len:int = 0;
		public function set len(value:int):void
		{
			_len = value;
		}
		public function get len():int
		{
			return _len;
		}
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		
		private var _idx:int = 0;
		public function get idx():int
		{
			return _idx;
		}
		public function set idx(value:int):void
		{
			_idx = value;
		}
		public function ProtocolField(key:String,value:Object,len:int = 0,idx:int = 0)
		{
			_key = key;
			_value = value;
			_len = len;
			_idx = idx;
		}
	}
}