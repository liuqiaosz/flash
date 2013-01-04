package pixel.core
{
	import pixel.utility.IDispose;

	public interface IPixelGeneric extends IPixel,IDispose
	{
		function get x():Number;
		function get y():Number;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set alpha(value:Number):void;
		function set visible(value:Boolean):void;
	}
}