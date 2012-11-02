package game.sdk
{
	import flash.events.IEventDispatcher;
	
	import game.sdk.assets.IAssetLibrary;
	import game.sdk.net.NetDataFormat;
	import game.sdk.preference.SceneConfig;
	import game.sdk.preference.SpriteConfig;

	public interface IPreference extends IEventDispatcher
	{
		function Initializer(Data:String,Mode:uint = 1):void;
		//是否需要登录
		function get SignNeed():Boolean;
		//登录模式,接入外部平台需要用到平台的用户资料
		function get SignMode():uint;
		//当前版本
		function get Version():uint;
		
		function get AssetLibraryList():Vector.<IAssetLibrary>;
		//主逻辑模块
		function get GameLuncher():String;
		
		function get SceneList():Vector.<SceneConfig>;
		function get SpriteList():Vector.<SpriteConfig>;
	}
}