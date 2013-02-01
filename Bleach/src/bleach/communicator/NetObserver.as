package bleach.communicator
{
	/**
	 * 网络消息观察者
	 * 
	 **/
	public class NetObserver
	{
		private static var _instance:INetObserver = null;
		public function NetObserver()
		{
		}
		
		public static function get instance():INetObserver
		{
			if(null == _instance)
			{
				_instance = new ObserverImpl();
			}
			return _instance;
		}
	}
}
import bleach.communicator.INetObserver;
import bleach.module.message.IMsg;

import flash.utils.Dictionary;

class ObserverImpl implements INetObserver
{
	private var _reciveQueue:Vector.<IMsg> = null;
	private var _diction:Dictionary = null;
	public function ObserverImpl()
	{
		_diction = new Dictionary();
		_reciveQueue = new Vector.<IMsg>();
	}
	
	public function addListener(command:int,callback:Function):void
	{
		if(!(command in _diction))
		{
			_diction[command] = new Vector.<Function>();
		}
		_diction[command].push(callback);
	}
	public function removeListener(command:int,callback:Function):void
	{
		if(command in _diction)
		{
			var calls:Vector.<Function> = _diction[command];
			if(calls.indexOf(callback) != -1)
			{
				calls.splice(calls.indexOf(callback),1);
			}
		}
	}
	
	public function broadcast(msg:IMsg):void
	{
		_reciveQueue.push(msg);
		
	}
	private var _recive:IMsg = null;
	public function update():void
	{
		if(_reciveQueue.length > 0)
		{
			_recive = _reciveQueue.shift();
			if(_recive)
			{
				if(_recive.id in _diction)
				{
					var calls:Vector.<Function> = _diction[_recive.id];
					var invoke:Function = null;
					for each(invoke in calls)
					{
						invoke(_recive);
					}
				}
			}
		}
	}
}

