package corecom.control.asset
{
	/**
	 * 组件资源加载管理
	 **/
	public class ControlAssetManager
	{
		private static var _Instance:IControlAssetManager = null;
		
		public function ControlAssetManager()
		{
		}
		
		public static function get Instance():IControlAssetManager
		{
			if(null == _Instance)
			{
				_Instance = new ControlAssetManagerImpl();
			}
			
			return _Instance;
		}
	}
}
import corecom.control.asset.IControlAssetManager;
import corecom.control.event.DownloadEvent;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import utility.IDispose;

class ControlAssetManagerImpl extends EventDispatcher implements IControlAssetManager,IDispose
{
	private var AssetDictionary:Dictionary = new Dictionary();
	//加载器
	private var AssetLoader:Loader = null;
	//加载队列
	private var DownloadQueue:Array = [];
	//锁定标识
	private var _Busy:Boolean = false;
	
	private var _AssetLibArray:Vector.<Loader> = new Vector.<Loader>();
	//正在加载的资源
	private var _LibraryLoading:int = 1;
	//正在加载的资源URL
	private var _LibraryLoadingUrl:String = "";
	//本次加载队列的文件总数
	private var _Total:int = 0;
	public function ControlAssetManagerImpl()
	{
	}
	
	public function Download(Uri:Array):void
	{
		if(Uri && Uri.length > 0)
		{
			_Total = Uri.length;
			DownloadQueue = Uri;
			StartDownloadQueue();
		}
	}
	
	/**
	 * 开始下载队列
	 **/
	protected function StartDownloadQueue():void
	{
		_LibraryLoadingUrl = DownloadQueue.pop();
		AssetLoader = new Loader();
		AssetLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,OnProgress);
		AssetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,OnError);
		AssetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,OnComplete);
		AssetLoader.contentLoaderInfo.addEventListener(Event.OPEN,OnStart);
		AssetLoader.load(new URLRequest(_LibraryLoadingUrl));
	}
	
	/**
	 **/
	private function OnProgress(event:ProgressEvent):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_START);
		Notify.CurrentIndex = _LibraryLoading;
		Notify.CurrentUri = _LibraryLoadingUrl;
		Notify.LoadedBytes = AssetLoader.contentLoaderInfo.bytesLoaded;
		Notify.TotalBytes = AssetLoader.contentLoaderInfo.bytesTotal;
		Notify.Total = _Total;
		dispatchEvent(Notify);
	}
	
	private function OnError(event:IOErrorEvent):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_ERROR);
		Notify.Message = event.text;
		dispatchEvent(Notify);
		if(DownloadQueue.length > 0)
		{
			//继续加载下一个资源
			StartDownloadQueue();
		}
	}
	
	private function OnComplete(event:Event):void
	{
		AssetLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,OnProgress);
		AssetLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,OnError);
		AssetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,OnComplete);
		AssetLoader.contentLoaderInfo.removeEventListener(Event.OPEN,OnStart);
		_AssetLibArray.push(AssetLoader);
		AssetLoader = null;
		
		if(DownloadQueue.length == 0)
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_SUCCESS);
			dispatchEvent(Notify);
			return;
		}
		//继续加载下一个资源
		StartDownloadQueue();
	}
	
	/**
	 * 加载开始
	 **/
	private function OnStart(event:Event):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_START);
		Notify.CurrentIndex = _LibraryLoading;
		Notify.CurrentUri = _LibraryLoadingUrl;
		dispatchEvent(Notify);
	}
	
	private function Clear():void
	{
		_LibraryLoading = 1;
		_Total = 0;
		_LibraryLoadingUrl = "";
		_Busy = false;
	}
	
	public function Dispose():void
	{
		if(_AssetLibArray && _AssetLibArray.length > 0)
		{
			var LibLoader:Loader = null;
			while((LibLoader = _AssetLibArray.pop()) as Loader != null)
			{
				if(LibLoader)
				{
					LibLoader.unload();
				}
			}
		}
	}
	
	public function FindAssetById(Id:String):Object
	{
		var Lib:Loader = null;
		//检查缓存是否有映射
		if(AssetDictionary.hasOwnProperty(Id))
		{
			return AssetDictionary[Id];
		}
		for(var Idx:int=0; Idx<_AssetLibArray.length; Idx++)
		{
			Lib = _AssetLibArray[Idx];
			if(Lib.contentLoaderInfo.applicationDomain.hasDefinition(Id))
			{
				var Prototype:Class = Lib.contentLoaderInfo.applicationDomain.getDefinition(Id) as Class;
				AssetDictionary[Id] = new Prototype();
				return AssetDictionary[Id];
			}
		}
		return null;
	}
	
	public function FindBitmapById(Id:String):Bitmap
	{
		var Result:Object = FindAssetById(Id);
		if(Result)
		{
			if(Result is BitmapData)
			{
				return new Bitmap(Result as BitmapData);
			}
		}
		return Result as Bitmap;
	}
}