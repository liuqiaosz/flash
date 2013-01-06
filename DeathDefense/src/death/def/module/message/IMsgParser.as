package death.def.module.message
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	

	public interface IMsgParser extends IEventDispatcher
	{
		function parse(data:ByteArray):IMsg;
		function getMsgPrototype(id:int):Object;
	}
}