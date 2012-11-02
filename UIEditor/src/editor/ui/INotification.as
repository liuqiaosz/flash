package editor.ui
{
	public interface INotification
	{
		function Show(Message:String,Duration:Number = 1500):void;
		function Hide():void;
	}
}