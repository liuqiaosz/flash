package bleach.communicator
{
	public class CommMarshal
	{
		private static var _instance:IComm = null;
		public function CommMarshal()
		{
		}
		
		public static function get instance():IComm
		{
			if(_instance == null)
			{
				_instance = new CommImpl();
				_instance.connect(CommConfigure.ip,CommConfigure.port);
			}
			return _instance;
		}
	}
}
import bleach.communicator.IComm;
import bleach.communicator.MessageParser;
import bleach.scene.GenericScene;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import bleach.communicator.PixelNetSocket;
import bleach.module.protocol.IProtocol;
import pixel.net.msg.tcp.IPixelTCPMessage;

/**
 * 网络数据包通讯
 * 
 **/
class CommImpl extends PixelNetSocket implements IComm
{
	private var _parser:MessageParser = null;
	private var _listenerList:Dictionary = null;
	public function CommImpl()
	{
		_listenerList = new Dictionary();
		_parser = new MessageParser();
	}
	
//	/**
//	 * 添加消息监听
//	 **/
//	public function addMessageListener(id:int,listener:Function):void
//	{
//		var queue:Vector.<Function> = null;
//		if(id in _listenerList)
//		{
//			queue = _listenerList[id];
//		}
//		else
//		{
//			queue = new Vector.<Function>();
//			_listenerList[id] = queue;
//		}
//		
//		if(queue.indexOf(listener) < 0)
//		{
//			queue.push(listener);
//		}
//	}
//	
//	/**
//	 * 移除消息监听
//	 * 
//	 **/
//	public function removeMessageListener(id:int,listener:Function):void
//	{
//		if(id in _listenerList)
//		{
//			var queue:Vector.<Function> = _listenerList[id];
//			if(queue.indexOf(listener) >= 0)
//			{
//				queue.splice(queue.indexOf(listener),1);
//			}
//		}
//	}
	
	/**
	 * 获取数据时的逻辑处理
	 * 
	 * 大数据的情况下需要保证数据包的完整性
	 **/
	override protected function validateMessage(buffer:ByteArray):Boolean
	{
		//保存数据包原下标
		var originalPos:int = buffer.position;
		buffer.position = 0;
		var len:int = buffer.readUnsignedShort();
		//恢复位置
		buffer.position = originalPos;
		if(len == buffer.bytesAvailable)
		{
			//数据包完整
			return true;
		}
		return false;
	}
	
	/**
	 * 数据校验通过后由基类数据接收函数调用
	 * 
	 **/
	override protected function dataRecived(data:ByteArray):void
	{
		//进行数据包解析
		var len:int = int(data.readUnsignedShort());
		if(len != data.bytesAvailable)
		{
			//数据长度不等于剩余数据长度表示数据包错误
		}
		else
		{
			var message:ByteArray = new ByteArray();
			data.readBytes(message,0,len);
			var msg:IPixelTCPMessage = _parser.decode(message);
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