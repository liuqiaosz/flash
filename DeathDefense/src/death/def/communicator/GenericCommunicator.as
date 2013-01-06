package death.def.communicator
{
	import death.def.cfg.GlobalConfig;
	import death.def.module.message.IMsg;
	import death.def.module.message.IMsgParser;
	import death.def.module.message.MsgGeneric;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import pixel.message.IPixelMessage;

	public class GenericCommunicator extends EventDispatcher implements IComm
	{
		private var _listenerList:Dictionary = null;
		private var _parser:IMsgParser = null;
		
		public function GenericCommunicator()
		{
			_listenerList = new Dictionary();
			var pack:String = GlobalConfig.instance.messageParser;
			var parserClass:Object = ApplicationDomain.currentDomain.getDefinition(pack);
			if(parserClass)
			{
				_parser = new parserClass() as IMsgParser;
			}
		}
		
		public function createMessage(id:int):IMsg
		{
			if(_parser)
			{
				var prototype:Object = _parser.getMsgPrototype(id);
				if(prototype)
				{
					return new prototype() as IMsg;
				}
			}
			return null;
		}
		
		/**
		 * 添加消息监听
		 **/
		public function addMessageListener(id:int,listener:Function):void
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
		public function removeMessageListener(id:int,listener:Function):void
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
		
		protected function parseMessage(data:ByteArray):IMsg
		{
			return _parser.parse(data);
		}
		
		protected function reciveNotify(msg:IMsg):void
		{
			if(msg.id in _listenerList)
			{
				//发起消息到达回调
				var queue:Vector.<Function> = _listenerList[msg.id];
				var call:Function = null;
				for each(call in queue)
				{
					call(msg);
				}
			}
		}
	}
}