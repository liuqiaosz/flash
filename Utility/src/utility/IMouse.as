package utility
{
	/**
	 * 鼠标控制类
	 **/
	public interface IMouse
	{
		function Register(Name:String,Images:Array,Show:Boolean = false,FrameRate:int=100):void;
		function ShowCursor(Name:String):void;
		function Default():void;
	}
}