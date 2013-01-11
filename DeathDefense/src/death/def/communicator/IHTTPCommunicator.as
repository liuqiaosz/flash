package death.def.communicator
{
	import death.def.module.message.IMsg;
	
	import flash.net.URLLoaderDataFormat;

	public interface IHTTPCommunicator extends IComm
	{
		function post(msg:IMsg):void;
		function get(msg:IMsg):void;
	}
}