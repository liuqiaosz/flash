package game.sdk.scene
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.sdk.net.ConnectionManager;
	import game.sdk.net.IDownloader;
	import game.sdk.net.event.DownloadEvent;

	/**
	 * 
	 **/
	public class SceneManager
	{
		private static var _Instance:ISceneManager = null;
		public function SceneManager()
		{
			
		}
		
		public static function get Instance():ISceneManager
		{
			if(_Instance == null)
			{
				_Instance = new SceneManagerImpl();
			}
			
			return _Instance;
		}
	}
}
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import game.sdk.net.ConnectionManager;
import game.sdk.net.IDownloader;
import game.sdk.net.event.DownloadEvent;
import game.sdk.scene.IScene;
import game.sdk.scene.ISceneManager;
import game.sdk.scene.event.SceneEvent;

import utility.IDispose;
import utility.Tools;

class SceneManagerImpl extends EventDispatcher implements ISceneManager,IDispose
{
	private var _ViewWidth:uint = 800;
	private var _ViewHeight:uint = 600;
	private var _SceneDictionary:Dictionary = null;
	private var _Loader:IDownloader = null;
	//private var _SceneClass:Class = null;
	public function SceneManagerImpl()
	{
		_SceneDictionary = new Dictionary();
	}
	
	public function ChangeViewSize(Width:uint,Height:uint):void
	{
		_ViewWidth = Width;
		_ViewHeight = Height;
	}
	
	/**
	 * 
	 **/
	public function FindSceneByName(Name:String):ByteArray
	{
		if(_SceneDictionary[Name])
		{
			return _SceneDictionary[Name];
		}
		return null;
	}
	
	/**
	 * 
	 **/
	public function LoadScene(NavURL:String):void
	{
		if(null == _Loader)
		{
			_Loader = ConnectionManager.GetBinaryDownloader();
			_Loader.addEventListener(DownloadEvent.DOWNLOAD_COMPLETE,LoadComplete);
		}
		
		_Loader.Download(NavURL);
	}
	
	private function LoadComplete(event:DownloadEvent):void
	{
		//Scene.Initializer(event.Data as ByteArray);
		
		//解析场景头
		var Pack:ByteArray = event.Data as ByteArray;
		Pack.uncompress();
		Pack.position = 0;
		var Mode:uint = Pack.readByte();
		var Name:String = Pack.readUTFBytes(Tools.ByteFinder(Pack,32));
		Pack.position = 0;
		_SceneDictionary[Name] = Pack;
		
		var Notify:SceneEvent = new SceneEvent(SceneEvent.SCENE_DOWNLOAD_COMPLETE);
		Notify.SceneName = Name;
		dispatchEvent(Notify);
	}
	
	public function Dispose():void
	{
//		var Scene:IScene = null;
//		for each(Scene in _SceneDictionary)
//		{
//			if(Scene)
//			{
//				Scene.Dispose();
//				Scene = null;
//			}
//		}
	}
}