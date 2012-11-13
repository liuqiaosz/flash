package pixel.message
{
	import mx.messaging.AbstractConsumer;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	public class MessageBus
	{
		private static var _instance:IMessageBus = null;
		public function MessageBus()
		{
		}
		
		PixelNs static function initiazlier():void
		{
			if(!_instance)
			{
				_instance = new MessageBusImpl();
			}
		}
		
		PixelNs static function get Instance():IMessageBus
		{
			return _instance;
		}
	}
}
import flash.utils.Dictionary;

import pixel.core.PixelNs;
import pixel.message.IMessageBus;
import pixel.message.Message;
import pixel.util.Config;

class MessageBusImpl implements IMessageBus
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
			_pool[message] = new Vector.<Function>(Config.MESSAGE_QUEUE_DEFAULTLENGTH);
		}
		
		_pool[message].push(callback);
	}
	//取消注册消息
	public function unRegister(message:String,callback:Function):void
	{
	}
	
	private var _queue:Vector.<Function> = null;
	public function dispatchMessage(message:Message):void
	{
		if(message.message in _pool)
		{
			_queue = new Vector.<Function>();
			var callback:Function = null;
			for each(callback in _queue)
			{
				callback(message);
			}
		}
	}
	
}