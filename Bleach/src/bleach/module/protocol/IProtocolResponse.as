package bleach.module.protocol
{
	import flash.utils.ByteArray;

	public interface IProtocolResponse extends IProtocol
	{
		function setMessage(data:ByteArray):void;
		function get respCode():int;
	}
}