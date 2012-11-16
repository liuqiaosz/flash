package pixel.worker.core
{
	import flash.events.IEventDispatcher;
	import flash.system.Worker;
	import flash.utils.ByteArray;

	public interface IPixelWorkerHelper extends IEventDispatcher
	{
		//ByteArray创建工作线程
		function createWorkerByByteArray(data:ByteArray):Worker;
		//通过网络加载远程工作线程模块
		function createWorkerByURL(url:String):void;
	}
}