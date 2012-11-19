package pixel.ui.control.asset
{
	import pixel.ui.control.UIControl;
	
	import flash.display.Bitmap;
	import flash.events.IEventDispatcher;
	
	import utility.swf.Swf;

	public interface IControlAssetManager extends IEventDispatcher
	{
		function Download(Uri:Array):void;
		function FindAssetById(Id:String):Object;
		function FindBitmapById(Id:String):Bitmap;
		function PushQueue(Url:String):void;
		function AssetHookRegister(Id:String,Target:UIControl):void;
		function AssetHookRemove(Id:String,Target:UIControl):void;
		function get AssetLibrary():Vector.<Swf>;
	}
}