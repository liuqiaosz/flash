package bleach.protocol
{
	import flash.utils.ByteArray;
	

	public interface IProtocol
	{
		function set id(value:int):void;
		function get id():int;
		function get toInfo():String;
		//function getMessage():Object;
		//function setMessage(data:Object):void;
//		function findFieldByName(name:String):Object;
//		function addField(name:String,value:Object,len:int = 0):MsgField;
	}
}