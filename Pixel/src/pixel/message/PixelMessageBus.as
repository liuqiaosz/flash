package pixel.message
{
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	public class PixelMessageBus
	{
		private static var _instance:IPixelMessageBus = null;
		public function PixelMessageBus()
		{
		}
		
		PixelNs static function initiazlier():void
		{
			if(!_instance)
			{
				_instance = new MessageBusImpl();
			}
		}
		
		PixelNs static function get instance():IPixelMessageBus
		{
			return _instance;
		}
	}
}
import flash.utils.Dictionary;

import pixel.core.PixelNs;
import pixel.message.IPixelMessage;
import pixel.message.IPixelMessageBus;
import pixel.message.PixelMessage;

class MessageBusImpl implements IPixelMessageBus
{
	use namespace PixelNs;
	
	//消息
	private var _pool:Dictionary = new Dictionary();
	
	public function MessageBusImpl()
	{
		_pool = new Dictionary();
	}
	
	//注册消息
	public function register(message:String,callback:Function):void
	{
		if(!(message in _pool))
		{
			_pool[message] = new Vector.<Function>();
		}
		
		_pool[message].push(callback);
	}
	//取消注册消息
	public function unRegister(message:String,callback:Function):void
	{
		
		if(message in _pool)
		{
			var queue:Vector.<Function> = _pool[message];
			if(queue.indexOf(callback) >= 0)
			{
				queue.splice(queue.indexOf(callback),1);
			}
		}
	}
	
	private var _queue:Vector.<Function> = null;
	public function dispatchMessage(message:IPixelMessage):void
	{
		if(message.message in _pool)
		{
			_queue = _pool[message.message];
			var callback:Function = null;
			for each(callback in _queue)
			{
				callback(message);
			}
		}
	}
}