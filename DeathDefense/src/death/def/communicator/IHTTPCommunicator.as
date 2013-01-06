package death.def.communicator
{
	import death.def.module.message.IMsg;
	
	import flash.net.URLLoaderDataFormat;

	public interface IHTTPCommunicator extends IComm
	{
		function post(url:String,msg:IMsg):void;
		function get(url:String,msg:IMsg):void;
	}
}