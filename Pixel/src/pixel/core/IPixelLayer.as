package pixel.core
{

	public interface IPixelLayer extends IPixelGeneric
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