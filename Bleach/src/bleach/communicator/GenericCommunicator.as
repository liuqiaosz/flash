package bleach.communicator
{
	import bleach.cfg.GlobalConfig;
	import bleach.module.protocol.IProtocol;
	import bleach.module.protocol.ProtocolGeneric;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelNode;
	import pixel.message.IPixelMessage;

	public class GenericCommunicator extends PixelNode implements IComm
	{
		private var _listenerList:Dictionary = null;
//		private var _parser:IMsgParser = null;
		
		public function GenericCommunicator()
		{
			_listenerList = new Dictionary();
//			var pack:String = GlobalConfig.instance.messageParser;
//			var parserClass:Object = getDefinitionByName(pack);
//			if(parserClass)
//			{
//				_parser = new parserClass() as IMsgParser;
//			}
		}
//		
//		public function createMessage(id:int):IMsg
//		{
//			if(_parser)
//			{
//				var prototype:Object = _parser.getMsgPrototype(id);
//				if(prototype)
//				{
//					return new prototype() as IMsg;
//				}
//			}
//			return null;
//		}
		
		/**
		 * 添加消息监听
		 **/
		public function addNetMessageListener(id:int,listener:Function):void
		{
			var queue:Vector.<Function> = null;
			if(id in _listenerList)
			{
				queue = _listenerList[id];
			}
			else
			{
				queue = new Vector.<Function>();
				_listenerList[id] = queue;
			}
			
			if(queue.indexOf(listener) < 0)
			{
				queue.push(listener);
			}
		}
		
		/**
		 * 移除消息监听
		 * 
		 **/
		public function removeNetMessageListener(id:int,listener:Function):void
		{
			if(id in _listenerList)
			{
				var queue:Vector.<Function> = _listenerList[id];
				if(queue.indexOf(listener) >= 0)
				{
					queue.splice(queue.indexOf(listener),1);
				}
			}
		}
		
//		protected function parseMessage(data:ByteArray):IMsg
//		{
//			return _parser.parse(data);
//		}
		
		protected function reciveNotify(msg:IProtocol):void
		{
			if(msg.id in _listenerList)
			{
				//发起消息到达回调
				var queue:Vector.<Function> = _listenerList[msg.id];
				var invoke:Function = null;
				for each(invoke in queue)
				{
					invoke(msg);
				}
			}
		}
	}
}