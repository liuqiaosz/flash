package death.def.module.message
{
	import flash.utils.ByteArray;
	

	public interface IMsg
	{
		function set id(value:int):void;
		function get id():int;
		function getMessage():Object;
		function setMessage(data:Object):void;
		function findFieldByName(name:String):Object;
		function addField(name:String,value:Object,len:int = 0):MsgField;
	}
}