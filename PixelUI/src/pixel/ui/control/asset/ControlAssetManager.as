package pixel.ui.control.asset
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
import pixel.ui.control.UIControl;
import pixel.ui.control.asset.IControlAssetManager;
import pixel.ui.control.event.DownloadEvent;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import utility.IDispose;
import utility.Tools;
import utility.swf.ByteStream;
import utility.swf.Swf;

class ControlAssetManagerImpl extends EventDispatcher implements IControlAssetManager,IDispose
{
	private var AssetDictionary:Dictionary = new Dictionary();
	//加载器
	//private var AssetLoader:Loader = null;
	private var Loader:URLLoader = null;
	//加载队列
	private var DownloadQueue:Array = [];
	//锁定标识
	private var _Busy:Boolean = false;
	
	private var _AssetLibArray:Vector.<Swf> = new Vector.<Swf>();
	//正在加载的资源
	private var _LibraryLoading:int = 1;
	//正在加载的资源URL
	private var _LibraryLoadingUrl:String = "";
	//本次加载队列的文件总数
	private var _Total:int = 0;
	public function ControlAssetManagerImpl()
	{
		Loader = new URLLoader();
		Loader.dataFormat = URLLoaderDataFormat.BINARY;
		Loader.addEventListener(ProgressEvent.PROGRESS,OnProgress);
		Loader.addEventListener(IOErrorEvent.IO_ERROR,OnError);
		Loader.addEventListener(Event.COMPLETE,OnComplete);
		Loader.addEventListener(Event.OPEN,OnStart);
	}
	
	public function Download(Uri:Array):void
	{
		if(Uri && Uri.length > 0)
		{
			_Total = Uri.length;
			DownloadQueue = DownloadQueue.concat(Uri);
			StartDownloadQueue();
		}
	}
	
	public function get AssetLibrary():Vector.<Swf>
	{
		return _AssetLibArray;
	}
	
	private var HookDict:Dictionary = new Dictionary();
	public function AssetHookRegister(Id:String,Target:UIControl):void
	{
		for each(var Lib:Swf in _AssetLibArray)
		{
			if(Lib.ClassKeyset.indexOf(Id) >= 0)
			{
				//当前库资源已加载
				Target.AssetComleteNotify(Id,Lib.FindObjectById(Id));
				return;
			}
		}
		var Vec:Vector.<UIControl> = null;
		if(Id in HookDict)
		{
			Vec = HookDict[Id];
			if(Vec.indexOf(Target) < 0)
			{
				Vec.push(Target);
			}
		}
		else
		{
			Vec = new Vector.<UIControl>();
			Vec.push(Target);
			HookDict[Id] = Vec;
		}
	}
	
	/**
	 * 资源回调注册解除
	 * 
	 * 
	 **/
	public function AssetHookRemove(Id:String,Target:UIControl):void
	{
		if(Id in HookDict)
		{
			var Vec:Vector.<UIControl> = HookDict[Id];
			if(Vec.indexOf(Target))
			{
				Vec.splice(Vec.indexOf(Target),1);
			}
		}
	}
	
	private function CheckHook(NewLibrary:Swf):void
	{
		var Key:String = "";
		var Vec:Vector.<UIControl> = null;
		var Hook:UIControl = null;
		for(Key in HookDict)
		{
			if(NewLibrary.IsContain(Key))
			{
				var Obj:Object = NewLibrary.FindObjectById(Key);
				Vec = HookDict[Key];
				for each(Hook in Vec)
				{
					Hook.AssetComleteNotify(Key,Obj);
				}
			}
		}
	}
	
	public function PushQueue(Url:String):void
	{
		DownloadQueue.push(Url);
		if(!_Busy)
		{
			StartDownloadQueue();
		}
	}
	
	/**
	 * 开始下载队列
	 **/
	protected function StartDownloadQueue():void
	{
		_Busy = true;
		_LibraryLoadingUrl = DownloadQueue.pop();
		Loader.load(new URLRequest(_LibraryLoadingUrl));
	}
	
	/**
	 **/
	private function OnProgress(event:ProgressEvent):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_START);
		Notify.CurrentIndex = _LibraryLoading;
		Notify.CurrentUri = _LibraryLoadingUrl;
		Notify.LoadedBytes = Loader.bytesLoaded;
		Notify.TotalBytes = Loader.bytesTotal;
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
		var Data:ByteArray = new ByteArray();
		Data.writeBytes(ByteArray(Loader.data),0,ByteArray(Loader.data).length);
		Data.position = 0;
		var Parse:Swf = new Swf(new ByteStream(Data));

		Parse.FileName = _LibraryLoadingUrl.substring(_LibraryLoadingUrl.lastIndexOf("\\") + 1);
		_AssetLibArray.push(Parse);
		CheckHook(Parse);
		
		var TaskNotify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_SINGLETASK_SUCCESS);
		TaskNotify.CurrentSwf = Parse;
		TaskNotify.CurrentUri = _LibraryLoadingUrl;
		TaskNotify.CurrentIndex = _LibraryLoading;
		
		dispatchEvent(TaskNotify);
		
		if(DownloadQueue.length == 0)
		{
			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_SUCCESS);
			dispatchEvent(Notify);
			_Busy = false;
//			
//			Loader.removeEventListener(ProgressEvent.PROGRESS,OnProgress);
//			Loader.removeEventListener(IOErrorEvent.IO_ERROR,OnError);
//			Loader.removeEventListener(Event.COMPLETE,OnComplete);
//			Loader.removeEventListener(Event.OPEN,OnStart);
//			Loader = null;
			
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
//		if(_AssetLibArray && _AssetLibArray.length > 0)
//		{
//			var LibLoader:Loader = null;
//			while((LibLoader = _AssetLibArray.pop()) as Loader != null)
//			{
//				if(LibLoader)
//				{
//					LibLoader.unload();
//				}
//			}
//		}
	}
	
	public function FindAssetById(Id:String):Object
	{
		var Lib:Swf = null;
		
		for each(Lib in _AssetLibArray)
		{
			if(Lib.IsContain(Id))
			{				
				return Lib.FindObjectById(Id);
			}
		}
		return null;
//		var Lib:Loader = null;
//		//检查缓存是否有映射
//		if(AssetDictionary.hasOwnProperty(Id))
//		{
//			return AssetDictionary[Id];
//		}
//		for(var Idx:int=0; Idx<_AssetLibArray.length; Idx++)
//		{
//			Lib = _AssetLibArray[Idx];
//			if(Lib.contentLoaderInfo.applicationDomain.hasDefinition(Id))
//			{
//				var Prototype:Class = Lib.contentLoaderInfo.applicationDomain.getDefinition(Id) as Class;
//				AssetDictionary[Id] = new Prototype();
//				return AssetDictionary[Id];
//			}
//		}
//		return null;
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