package bleach.module.protocol
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	

	public class ProtocolGeneric implements IProtocol
	{
		protected var _charset:String = Charset.UTF8;
		protected var _id:int = 0;
		//消息ID
		public function get id():int
		{
			return _id;
		}
		public function set id(value:int):void
		{
			_id = value;
		}
		
		protected function messageAnalysis(data:ByteArray):void
		{
		}
		
//		protected var _fields:Vector.<MsgField> = null;
//		protected var _fieldMap:Dictionary = null;
//		public function addField(value:PixelNetMessageField):void
//		{
//			_fields.push(value);
//			_fieldMap[value.key] = value;
//		}
		
//		public function addField(name:String,value:Object,len:int = 0):MsgField
//		{
//			var field:MsgField = new MsgField(name,value,len);
//			_fields.push(field);
//			_fieldMap[field.key] = field;
//			return field;
//		}
//		public function get fields():Vector.<MsgField>
//		{
//			return _fields;
//		}
//		
//		public function findFieldByName(name:String):Object
//		{
//			if(name in _fieldMap)
//			{
//				var field:MsgField = _fieldMap[name];
//				return field.value;
//			}
//			return "";
//		}
		
		public function ProtocolGeneric(id:int = 0,charset:String = "utf-8")
		{
			_id = id;
			_charset = charset;
//			_fields = new Vector.<MsgField>();
//			_fieldMap = new Dictionary();
		}		
//		public function parse(data:ByteArray):void
//		{
//			var msgId:int = data.readUnsignedShort();
//			
//		}
//		
//		public function getField(name:String):String
//		{
//			return "";
//		}
	}
}