package game.sdk
{
	public class GamePreference
	{
		private static var _Impl:IPreference = null;
		
		public function GamePreference()
		{
		}
		
		public static function get Instance():IPreference
		{
			if(null == _Impl)
			{
				_Impl = new PreferenceImpl();
			}
			return _Impl;
		}
	}
}
import flash.events.EventDispatcher;
import flash.sensors.Accelerometer;
import flash.utils.ByteArray;

import game.sdk.IPreference;
import game.sdk.assets.AssetLibrary;
import game.sdk.assets.IAssetLibrary;
import game.sdk.error.GameError;
import game.sdk.event.GameEvent;
import game.sdk.net.NetDataFormat;
import game.sdk.preference.SceneConfig;
import game.sdk.preference.SpriteConfig;

class PreferenceImpl extends EventDispatcher implements IPreference
{
	private var _AssetLibList:Vector.<IAssetLibrary> = new Vector.<IAssetLibrary>();
	private var _SceneList:Vector.<SceneConfig> = new Vector.<SceneConfig>();
	private var _SpriteList:Vector.<SpriteConfig> = new Vector.<SpriteConfig>();
	public function PreferenceImpl()
	{
	}
	
	public function Initializer(Data:String,Mode:uint = NetDataFormat.XML):void
	{
		var Doc:XML = new XML(Data);
		//获取配置版本
		_Version = Doc.@version;
		var Idx:uint = 0;
		var AssetNodes:XMLList = Doc.AssetLibrarys.AssetLibrary;
		for(Idx=0; Idx<AssetNodes.length(); Idx++)
		{
			var Lib:IAssetLibrary = new AssetLibrary();
			Lib.Id = AssetNodes[Idx].@id;
			Lib.Url = AssetNodes[Idx].@url;
			_AssetLibList.push(Lib);
		}
		
		var SceneNodes:XMLList = Doc.Scenes.Scene;
		for(Idx=0; Idx<SceneNodes.length(); Idx++)
		{
			var Scene:SceneConfig = new SceneConfig();
			Scene.Name = SceneNodes[Idx].@name;
			Scene.URL = SceneNodes[Idx].@url;
			_SceneList[Scene.Name] = Scene;
		}
		
		var Sprites:XMLList = Doc.Sprites.Sprite;
		for(Idx=0; Idx<Sprites.length(); Idx++)
		{
			var Sprite:SpriteConfig = new SpriteConfig();
			Sprite.URL = Sprites[Idx].@url;
			_SpriteList.push(Sprite);
		}
	}
	
	//是否需要登录
	public function get SignNeed():Boolean
	{
		return false;
	}
	
	//登录模式,接入外部平台需要用到平台的用户资料
	public function get SignMode():uint
	{
		return null;
	}
	
	private var _Version:uint = 0;
	//当前版本
	public function get Version():uint
	{
		return null;
	}
	
	
	public function get GameLuncher():String
	{
		return "1";
	}
	
	
	public function get AssetLibraryList():Vector.<IAssetLibrary>
	{
		return _AssetLibList;
	}
	
	public function get SceneList():Vector.<SceneConfig>
	{
		return _SceneList;
	}
	
	public function get SpriteList():Vector.<SpriteConfig>
	{
		return _SpriteList;
	}
	
}