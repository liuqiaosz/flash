package corecom.control.asset
{
	import flash.display.Bitmap;
	import flash.events.IEventDispatcher;

	public interface IControlAssetManager extends IEventDispatcher
	{
		function Download(Uri:Array):void;
		function FindAssetById(Id:String):Object;
		function FindBitmapById(Id:String):Bitmap;
	}
}