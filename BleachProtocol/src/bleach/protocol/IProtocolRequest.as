package bleach.protocol
{
	import flash.utils.ByteArray;

	public interface IProtocolRequest extends IProtocol
	{
		function getMessage():ByteArray;
	}
}