package pixel.ui.control
{
	import flash.display.DisplayObject;
	
	/**
	 * Sprite对象接口定义
	 * 
	 **/
	public interface IFlashSprite
	{
		function set x(value:Number):void;
		function get x():Number;
		
		function set y(value:Number):void;
		function get y():Number;
		
		function set width(value:Number):void;
		function get width():Number;
		
		function set height(value:Number):void;
		function get height():Number;
		
		function get owner():IUIContainer;
		
		function get mouseX():Number;
		function get mouseY():Number;
		
		function removeChild(child:DisplayObject):DisplayObject;
	}
}