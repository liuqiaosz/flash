package pixel.core
{
	import flash.display.DisplayObject;
	
	import pixel.utility.IDispose;
	import pixel.utility.IUpdate;

	public interface IPixelLayer extends IPixelGeneric,IDispose,IPixelMessageProxy,IUpdate
	{
		function initializer():void;
		function reset():void;
		function get nodes():Vector.<DisplayObject>;
		function clearNodes():void;
		function get id():String;
		function set id(value:String):void;
	}
}