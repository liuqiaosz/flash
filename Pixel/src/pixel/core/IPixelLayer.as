package pixel.core
{
	import pixel.utility.IDispose;

	public interface IPixelLayer extends IPixelGeneric,IDispose
	{
		function initializer():void;
		function reset():void;
		function get nodes():Vector.<IPixelNode>;
		
		function addNode(value:IPixelNode):void;
		function removeNode(value:IPixelNode):void;
		function get id():String;
		function set id(value:String):void;
	}
}