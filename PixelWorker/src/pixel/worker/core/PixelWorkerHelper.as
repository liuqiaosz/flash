package pixel.worker.core
{
	public class PixelWorkerHelper
	{
		public function PixelWorkerHelper()
		{
		}
	}
}

import flash.events.EventDispatcher;
import flash.system.MessageChannel;
import flash.system.Worker;
import flash.system.WorkerDomain;
import flash.utils.ByteArray;

import pixel.worker.core.IPixelWorkerHelper;
import pixel.worker.core.PixelWorkerGeneric;

class PixelWorkerHelperImpl extends EventDispatcher implements IPixelWorkerHelper
{
	/**
	 * ByteArray创建工作线程
	 * 
	 */
	public function createWorkerByByteArray(data:ByteArray):Worker
	{
		if(data)
		{
			var work:Worker = WorkerDomain.current.createWorker(data);
			//创建当前主SWF的消息接收通道，同时也是子工作线程的数据发送通道
			var channel:MessageChannel = work.createMessageChannel(Worker.current);
			work.setSharedProperty(PixelWorkerGeneric.CHANNEL_SENDER,channel);
			
			//创建当前主SWF对子工作线程的数据发送通道，子工作线程通过该通道接收主swf的消息
			channel = Worker.current.createMessageChannel(work);
			work.setSharedProperty(PixelWorkerGeneric.CHANNEL_RECIVE,channel);
			
			return work;
		}
		return null;
	}
	
	/**
	 * 通过网络加载远程工作线程模块
	 */
	public function createWorkerByURL(url:String):void
	{
	}
}