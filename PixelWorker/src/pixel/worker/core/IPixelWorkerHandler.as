package pixel.worker.core
{
	import flash.system.MessageChannel;

	public interface IPixelWorkerHandler
	{
		function execute(reciveChannel:MessageChannel = null,senderChannel:MessageChannel = null):void;
		function terminal():void;
	}
}