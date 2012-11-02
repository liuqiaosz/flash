package game.sdk.assets
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;

	public interface IAssetLibrary
	{
		function get Id():String;
		function set Id(Value:String):void;
		function get Url():String;
		function set Url(Value:String):void;
		function set Data(Value:ByteArray):void;
		function get Data():ByteArray;
		function FindBitmapById(Id:String):Bitmap;
		function Decode():void;
	}
}