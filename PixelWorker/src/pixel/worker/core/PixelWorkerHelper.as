package pixel.worker.core
{
	import flash.net.registerClassAlias;
	
	import pixel.worker.message.PixelWorkerMessageRequest;
	import pixel.worker.message.PixelWorkerMessageResponse;

	public class PixelWorkerHelper
	{
		private static var _instance:IPixelWorkerHelper = null;
		public function PixelWorkerHelper()
		{
			
		}
		
		public static function get instance():IPixelWorkerHelper
		{
			if(!_instance)
			{
				_instance = new PixelWorkerHelperImpl();
			}
			return _instance;
		}
	}
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.MessageChannel;
import flash.system.Worker;
import flash.system.WorkerDomain;
import flash.utils.ByteArray;

import pixel.worker.core.IPixelWorkerHelper;
import pixel.worker.core.PixelWorker;
import pixel.worker.core.PixelWorkerGeneric;
import pixel.worker.event.PixelWorkerEvent;

class PixelWorkerHelperImpl extends EventDispatcher implements IPixelWorkerHelper
{
	/**
	 * ByteArray创建工作线程
	 * 
	 */
	public function createWorkerByByteArray(data:ByteArray):PixelWorker
	{
		if(data)
		{
			var work:Worker = WorkerDomain.current.createWorker(data,true);
			//创建当前主SWF的消息接收通道，同时也是子工作线程的数据发送通道
			var channel:MessageChannel = work.createMessageChannel(Worker.current);
			work.setSharedProperty(PixelWorkerGeneric.CHANNEL_SENDER,channel);
			
			//创建当前主SWF对子工作线程的数据发送通道，子工作线程通过该通道接收主swf的消息
			channel = Worker.current.createMessageChannel(work);
			work.setSharedProperty(PixelWorkerGeneric.CHANNEL_RECIVE,channel);
			
			return new PixelWorker(work);
		}
		return null;
	}
	
	private var loader:URLLoader = null;
	/**
	 * 通过网络加载远程工作线程模块
	 */
	public function createWorkerByURL(url:String):void
	{
		loader = new URLLoader();
		loader.dataFormat = URLLoaderDataFormat.BINARY;
		loader.addEventListener(Event.COMPLETE,onRemoteWorkerComplete);
		loader.addEventListener(IOErrorEvent.IO_ERROR,onRemoteWorkerIOError);
		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onRemoteWorkerSecurityError);
		loader.load(new URLRequest(url));
	}
	
	private function onRemoteWorkerComplete(event:Event):void
	{
		var worker:PixelWorker = createWorkerByByteArray(loader.data as ByteArray);
		var notify:PixelWorkerEvent = new PixelWorkerEvent(PixelWorkerEvent.WORKER_COMPLETE);
		notify.message = worker;
		dispatchEvent(notify);
		loaderCleanup();
	}
	private function onRemoteWorkerIOError(event:Event):void
	{}
	private function onRemoteWorkerSecurityError(event:Event):void
	{}
	
	private function loaderCleanup():void
	{
		loader.removeEventListener(Event.COMPLETE,onRemoteWorkerComplete);
		loader.removeEventListener(IOErrorEvent.IO_ERROR,onRemoteWorkerIOError);
		loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onRemoteWorkerSecurityError);
		loader = null;
	}
}