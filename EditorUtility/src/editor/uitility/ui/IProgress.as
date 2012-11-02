package editor.uitility.ui
{
	public interface IProgress
	{
		function Show():void;
		function Hide():void;
		function Update(Value:int,MaxValue:int):void;
		function set Label(Value:String):void;
	}
}