package bleach.communicator
{
	import bleach.module.protocol.IProtocol;
	
	import flash.net.URLLoaderDataFormat;

	public interface IHTTPCommunicator extends IComm
	{
		function post(msg:IProtocol):void;
		function get(msg:IProtocol):void;
	}
}