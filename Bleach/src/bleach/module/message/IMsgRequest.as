package bleach.module.message
{
	import flash.utils.ByteArray;

	public interface IMsgRequest extends IMsg
	{
		function getMessage():ByteArray;
	}
}