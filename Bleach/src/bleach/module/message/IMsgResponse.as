package bleach.module.message
{
	import flash.utils.ByteArray;

	public interface IMsgResponse extends IMsg
	{
		function setMessage(data:ByteArray):void;
	}
}