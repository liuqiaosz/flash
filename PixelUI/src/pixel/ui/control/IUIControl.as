package pixel.ui.control
{
	import flash.events.IEventDispatcher;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.utility.IDispose;
	import pixel.utility.ISerializable;
	import pixel.utility.IUpdate;

	/**
	 * 
	 * UI基本接口
	 * 
	 **/
	public interface IUIControl extends IDispose,IEventDispatcher,ISerializable,IUpdate
	{
		//绘制接口
		function Render():void;
		
		function get Id():String;
		function set Id(Value:String):void;
		function get Version():uint;
		function set Version(Value:uint):void;
		function get Style():IVisualStyle;
		function set Style(value:IVisualStyle):void;
		function initializer():void;
		
		function set x(value:Number):void;
		function get x():Number;
		
		function set y(value:Number):void;
		function get y():Number;
		//以中心为注册点进行缩放
		//function CenterScale(Value:Number):void;
	}
}