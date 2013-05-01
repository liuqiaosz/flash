package pixel.ui.control
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.core.PixelUINS;
	import pixel.utility.IDispose;
	import pixel.utility.ISerializable;
	import pixel.utility.IUpdate;
	
	use namespace PixelUINS;
	/**
	 * 
	 * UI基本接口
	 * 
	 **/
	public interface IUIControl extends IDispose,IEventDispatcher,ISerializable,IUpdate,IFlashSprite
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
		//以中心为注册点进行缩放
		//function CenterScale(Value:Number):void;
	}
}