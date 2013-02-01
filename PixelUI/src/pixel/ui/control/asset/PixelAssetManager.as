package pixel.ui.control.asset
{
	import pixel.ui.core.PixelUINS;

	use namespace PixelUINS;
	/**
	 * 组件资源加载管理
	 **/
	public class PixelAssetManager
	{
		private static var _Instance:IPixelAssetManager = null;
		
		public function PixelAssetManager()
		{
		}
		
		public static function get instance():IPixelAssetManager
		{
			if(null == _Instance)
			{
				_Instance = new ControlAssetManagerImpl();
			}
			
			return _Instance;
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import pixel.ui.control.UIControl;
import pixel.ui.control.asset.IAsset;
import pixel.ui.control.asset.IAssetLibrary;
import pixel.ui.control.asset.IPixelAssetManager;
import pixel.ui.control.asset.PixelAssetEmu;
import pixel.ui.control.asset.PixelLoaderAssetLibrary;
import pixel.ui.control.asset.PixelTextureAssetLibrary;
import pixel.ui.control.event.DownloadEvent;
import pixel.utility.IDispose;
import pixel.utility.Tools;

class ControlAssetManagerImpl extends EventDispatcher implements IPixelAssetManager,IDispose
{
	private var AssetDictionary:Dictionary = new Dictionary();
	//加载器
	//private var AssetLoader:Loader = null;
	//private var _Loader:Loader = null;
	private var _loader:URLLoader = null;
	//加载队列
	private var DownloadQueue:Vector.<TaskNode> = new Vector.<TaskNode>();
	//锁定标识
	private var _Busy:Boolean = false;
	
	private var _AssetLibArray:Vector.<IAssetLibrary> = new Vector.<IAssetLibrary>();
	//正在加载的资源
	private var _LibraryLoading:int = 1;
	//正在加载的资源URL
	//private var _LibraryLoadingUrl:String = "";
	private var loadingTask:TaskNode = null;
	//本次加载队列的文件总数
	private var _Total:int = 0;
	
	private var _self:ControlAssetManagerImpl = null;
	public function ControlAssetManagerImpl()
	{
		_loader = new URLLoader();
		//_Loader = new Loader();
		_loader.dataFormat = URLLoaderDataFormat.BINARY;
		//			_Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,OnProgress);
		//			_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,OnError);
		//			_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,OnComplete);
		//			_Loader.contentLoaderInfo.addEventListener(Event.OPEN,OnStart);
		_loader.addEventListener(ProgressEvent.PROGRESS,OnProgress);
		_loader.addEventListener(IOErrorEvent.IO_ERROR,OnError);
		_loader.addEventListener(Event.COMPLETE,OnComplete);
		_loader.addEventListener(Event.OPEN,OnStart);
		_self = this;
	}
	
	public function download(url:String,type:int = PixelAssetEmu.ASSET_SWF):void
	{
		var task:TaskNode = new TaskNode();
		task.url = url;
		task.type = type;
		DownloadQueue.push(task);
		
		if(!_Busy)
		{
			StartDownloadQueue();
		}
	}
	
//	public function Download(Uri:Array):void
//	{
//		if(Uri && Uri.length > 0)
//		{
//			_Total = Uri.length;
//			DownloadQueue = DownloadQueue.concat(Uri);
//			StartDownloadQueue();
//		}
//	}
	
	public function get Librarys():Vector.<IAssetLibrary>
	{
		return _AssetLibArray;
	}
	
	public function addAssetLibrary(lib:IAssetLibrary):void
	{
		_AssetLibArray.push(lib);
	}
	
	public function removeAssetLibrary(id:String):void
	{
		for each(var lib:IAssetLibrary in _AssetLibArray)
		{
			if(id == lib.id)
			{
				_AssetLibArray.splice(_AssetLibArray.indexOf(lib),1);
				return;
			}
		}
	}
	
	private var HookDict:Dictionary = new Dictionary();
	public function AssetHookRegister(Id:String,Target:UIControl):void
	{
		for each(var Lib:IAssetLibrary in _AssetLibArray)
		{
			if(Lib.hasDefinition(Id))
			{
				//当前库资源已加载
				Target.AssetComleteNotify(Id,Lib.findAssetByName(Id));
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
	
	private function CheckHook(NewLibrary:IAssetLibrary):void
	{
		var Key:String = "";
		var Vec:Vector.<UIControl> = null;
		var Hook:UIControl = null;
		for(Key in HookDict)
		{
			if(NewLibrary.hasDefinition(Key))
			{
				var asset:IAsset = NewLibrary.findAssetByName(Key);
				Vec = HookDict[Key];
				for each(Hook in Vec)
				{
					Hook.AssetComleteNotify(Key,asset);
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
		if(!_Busy)
		{
			_Busy = true;
			loadingTask = DownloadQueue.shift();
			
			//var ctx:LoaderContext = new LoaderContext();
			//ctx.allowCodeImport = true;
			_loader.load(new URLRequest(loadingTask.url));
		}
	}
	
	/**
	 **/
	private function OnProgress(event:ProgressEvent):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_START);
		Notify.CurrentIndex = _LibraryLoading;
		Notify.CurrentUri = loadingTask.url;
		Notify.LoadedBytes = event.bytesLoaded;
		Notify.TotalBytes = event.bytesTotal;
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
		var lib:IAssetLibrary = null;
		var id:String = Tools.getFileName(loadingTask.url);
		var Notify:DownloadEvent = null;
		switch(loadingTask.type)
		{
			case PixelAssetEmu.ASSET_SWF:
				
				var reader:Loader = new Loader();
				reader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(readEvent:Event):void{
					lib = new PixelLoaderAssetLibrary(reader,id);
					_AssetLibArray.push(lib);
					CheckHook(lib);
					Notify = new DownloadEvent(DownloadEvent.DOWNLOAD_SUCCESS);
					dispatchEvent(Notify);
					if(DownloadQueue.length > 0)
					{
						//继续加载下一个资源
						StartDownloadQueue();
					}
					else
					{
						_Busy = false;
					}
				});
				var ctx:LoaderContext = new LoaderContext();
				//ctx.applicationDomain = ApplicationDomain.currentDomain;
				ctx.allowCodeImport = true;
				reader.loadBytes(_loader.data as ByteArray,ctx);
				break;
		}
		
//		if(DownloadQueue.length > 0)
//		{
//			//继续加载下一个资源
//			StartDownloadQueue();
//		}
//		else
//		{
//			_Busy = false;
//		}
		//继续加载下一个资源
	}
	
//	private function readToLoader(event:Event):void
//	{
//		var id:String = Tools.getFileName(this._LibraryLoadingUrl);
//		var lib:LoaderAssetLibrary = new LoaderAssetLibrary(_reader,id);
//		_AssetLibArray.push(lib);
//		CheckHook(lib);
//		clearLoader();
//		_reader.unload();
//		_reader = null;
//		if(DownloadQueue.length > 0)
//		{
//			//继续加载下一个资源
//			StartDownloadQueue();
//		}
//		else
//		{
//			var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_SUCCESS);
//			dispatchEvent(Notify);
//			_Busy = false;
//		}
//	}
	
//	private function clearLoader():void
//	{
//		_Loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,OnProgress);
//		_Loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,OnError);
//		_Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,OnComplete);
//		_Loader.contentLoaderInfo.removeEventListener(Event.OPEN,OnStart);
//		_Loader.unload();
//		_Loader = null;
//	}
	
	private function definitionParse():Vector.<Object>
	{
		return null;
	}
	/**
	 * 加载开始
	 **/
	private function OnStart(event:Event):void
	{
		var Notify:DownloadEvent = new DownloadEvent(DownloadEvent.DOWNLOAD_START);
		Notify.CurrentIndex = _LibraryLoading;
		Notify.CurrentUri = loadingTask.url;
		dispatchEvent(Notify);
	}
	
	private function Clear():void
	{
		_LibraryLoading = 1;
		_Total = 0;
		loadingTask = null;
		_Busy = false;
	}
	
	public function dispose():void
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
	
	public function FindAssetById(Id:String):IAsset
	{
		var Lib:IAssetLibrary = null;
		for each(Lib in _AssetLibArray)
		{
			if(Lib.hasDefinition(Id))
			{				
				return Lib.findAssetByName(Id);
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

class TaskNode
{
	public var url:String = "";
	public var type:int = PixelAssetEmu.ASSET_SWF;
}