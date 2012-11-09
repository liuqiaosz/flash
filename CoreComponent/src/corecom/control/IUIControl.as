package corecom.control
{
	import flash.events.IEventDispatcher;
	
	import utility.IDispose;
	import utility.ISerializable;

	/**
	 * 
	 * UI基本接口
	 * 
	 **/
	public interface IUIControl extends IDispose,IEventDispatcher,ISerializable
	{
		//绘制接口
		function Render():void;
		
		function get Id():String;
		function set Id(Value:String):void;
		function get Version():uint;
		function set Version(Value:uint):void;
		//以中心为注册点进行缩放
		//function CenterScale(Value:Number):void;
	}
}