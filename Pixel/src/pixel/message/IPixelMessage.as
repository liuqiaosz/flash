package pixel.message
{
	public interface IPixelMessage
	{
		function set message(value:String):void;
		function get message():String;
		function get target():Object;
		function set target(value:Object):void;
		function set value(data:Object):void;
		function get value():Object;
	}
}