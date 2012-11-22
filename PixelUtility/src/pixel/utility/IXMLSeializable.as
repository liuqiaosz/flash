package pixel.utility
{
	public interface IXMLSeializable
	{
		function Encode():String;
		function Decode(Data:String):void;
	}
}