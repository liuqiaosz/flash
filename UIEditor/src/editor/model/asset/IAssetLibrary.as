package editor.model.asset
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import utility.ISerializable;

	public interface IAssetLibrary extends ISerializable
	{
		function get Id():String;
		function set Id(Value:String):void;
		function get Name():String;
		function set Name(Value:String):void;
		function get Version():uint;
		function set Version(Value:uint):void
		function get Total():uint;
		function get Type():uint;
		
		function get AssetList():Array;
		function FindAssetById(Id:String):Asset;
		function AddBitmapFromByteArray(Pixels:ByteArray,ImgWidth:uint,ImgHeight:uint):Asset;
		function AddBitmap(Image:Bitmap):Asset;
		function DeleteAsset(Item:Asset):void;
	}
}