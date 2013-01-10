package death.def.communicator
{
	public class HTTPCommunicator
	{
		private static var _instance:IHTTPCommunicator = null;
		public function HTTPCommunicator()
		{
		}
		
		public static function get instance():IHTTPCommunicator
		{
			if(!_instance)
			{
				_instance = new CommunicatorImpl();
			}
			return _instance;
		}
		
	}
}
import death.def.communicator.GenericCommunicator;
import death.def.communicator.IHTTPCommunicator;
import death.def.module.message.IMsg;
import death.def.module.message.MsgHTTP;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.engine.BreakOpportunity;
import flash.utils.ByteArray;

class CommunicatorImpl extends GenericCommunicator implements IHTTPCommunicator
{
	private var _loader:URLLoader = null;
	
	public function CommunicatorImpl()
	{
		_loader = new URLLoader();
		_loader.dataFormat = URLLoaderDataFormat.BINARY;
		_loader.addEventListener(Event.COMPLETE,requestComplete);
	}
	
	private function requestComplete(event:Event):void
	{
		var data:ByteArray = new ByteArray();
		var source:ByteArray = _loader.data as ByteArray;
		source.readBytes(data,0,source.length);
		var msg:IMsg = parseMessage(data);
		reciveNotify(msg);
	}

	public function post(url:String,msg:IMsg):void
	{
		var vars:URLVariables = new URLVariables(msg.getMessage());
		var req:URLRequest = new URLRequest(url);
		req.contentType="application/octet-stream";
		req.data = msg.getMessage();
		req.method = URLRequestMethod.POST;
		_loader.load(req);
	}
	
	public function get(url:String,msg:IMsg):void
	{}
}