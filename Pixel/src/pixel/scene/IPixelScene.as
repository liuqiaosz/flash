package pixel.scene
{
	import pixel.core.IPixelGeneric;
	import pixel.core.IPixelNode;

	public interface IPixelScene extends IPixelGeneric
	{
		function reset():void;
		function get nodes():Vector.<IPixelNode>;
		function update():void;
		
		function addNode(value:IPixelNode):void;
		function removeNode(value:IPixelNode):void;
	}
}