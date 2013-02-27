package bleach.communicator
{
	import bleach.protocol.IProtocol;
	
	import flash.net.URLLoaderDataFormat;

	public interface IHTTPCommunicator extends ICommunicator
	{
		function post(msg:IProtocol):void;
		function get(msg:IProtocol):void;
	}
}