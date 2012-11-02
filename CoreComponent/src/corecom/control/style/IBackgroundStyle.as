package corecom.control.style
{
	import flash.display.Bitmap;

	public interface IBackgroundStyle
	{
		//背景颜色
		function set BackgroundColor(Value:uint):void;
		function get BackgroundColor():uint;
		
		//背景透明度
		function set BackgroundAlpha(Value:Number):void;
		function get BackgroundAlpha():Number;
		
		//背景图片
		function set BackgroundImage(Value:Bitmap):void;
		function get BackgroundImage():Bitmap;
		
		function set ImageFillType(Value:int):void;
		function get ImageFillType():int;
		
		function set BackgroundImageId(Value:String):void;
		function get BackgroundImageId():String;
	}
}