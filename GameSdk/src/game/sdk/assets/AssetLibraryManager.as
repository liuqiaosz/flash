package game.sdk.assets
{
	public class AssetLibraryManager
	{
		private static var _Instance:IAssetLibraryManager = null;
		public function AssetLibraryManager()
		{
		}
		
		public static function get Instance():IAssetLibraryManager
		{
			if(_Instance == null)
			{
				_Instance = new AssetLibraryManagerImpl();
			}
			return _Instance;
		}
	}
}

import flash.display.Bitmap;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import game.sdk.assets.IAssetLibrary;
import game.sdk.assets.IAssetLibraryManager;
import game.sdk.assets.event.AssetEvent;
import game.sdk.net.ConnectionManager;
import game.sdk.net.downloader.IBatchDownloader;
import game.sdk.net.event.BatchDownloadEvent;

class AssetLibraryManagerImpl extends EventDispatcher implements IAssetLibraryManager
{
	//已下载资源缓存
	private var _DownloadedAssetLibrary:Dictionary = new Dictionary();
	private var _DownloadProcess:Boolean = false;
	private var _Downloader:IBatchDownloader = null;
	//当前等待的队列
	private var _WaitQueue:Vector.<IAssetLibrary> = new Vector.<IAssetLibrary>();
	private var _DownloadUrlQueue:Vector.<String> = new Vector.<String>();
	private var _DownloadAssetLibQueue:Vector.<IAssetLibrary> = new Vector.<IAssetLibrary>();
	
	public function AssetLibraryManagerImpl()
	{
		super();
		_Downloader = ConnectionManager.GetBinaryBatchDownloader();
		_Downloader.addEventListener(BatchDownloadEvent.DOWNLOAD_COMPLETE,OnSingleDownloadComplete);
		_Downloader.addEventListener(BatchDownloadEvent.DOWNLOAD_QUEUE_COMPLETE,OnQueueDownloadComplete);
	}
	
	/**
	 * 开始下载队列
	 **/
	private function StartDownload():void
	{
		if(_DownloadAssetLibQueue.length > 0)
		{
			_DownloadProcess = true;
			for(var Idx:int = 0; Idx<_DownloadAssetLibQueue.length; Idx++)
			{
				_DownloadUrlQueue = new Vector.<String>();
				_DownloadUrlQueue.push(_DownloadAssetLibQueue[Idx].Url);
			}
			_Downloader.StartBatchDownload(_DownloadUrlQueue);
		}
	}
	
	public function DownloadAssetLibrary(Asset:IAssetLibrary):void
	{
		//正在下载队列则将任务放入等待队列
		if(_DownloadProcess)
		{
			_WaitQueue.push(Asset);
		}
		else
		{
			_DownloadUrlQueue.push(Asset.Url);
			_DownloadAssetLibQueue.push(Asset);
			StartDownload();
		}
	}
	
	public function BatchDownloadAssetLibrary(AssetLibs:Vector.<IAssetLibrary>):void
	{
		if(_DownloadProcess)
		{
			for(var Idx:int = 0; Idx<AssetLibs.length; Idx++)
			{
				_WaitQueue.push(AssetLibs[Idx]);
				_DownloadUrlQueue.push(AssetLibs[Idx].Url);
			}
		}
		else
		{
			_DownloadAssetLibQueue = _DownloadAssetLibQueue.concat(AssetLibs);
			StartDownload();
		}	
	}
	
	/**
	 * 队列单个任务下载完成
	 **/
	private function OnSingleDownloadComplete(event:BatchDownloadEvent):void
	{
		var Idx:int = event.DownloadIndex;
		if(Idx < _DownloadAssetLibQueue.length)
		{
			var Lib:IAssetLibrary = _DownloadAssetLibQueue[Idx];
			//校验完成的下载资源是否正确映射模块
			if(Lib.Url == event.DownloadURL)
			{
				Lib.Data = event.CompleteContent as ByteArray;
				_DownloadedAssetLibrary[Lib.Id] = Lib;
				Lib.Decode();
				var Notify:AssetEvent = new AssetEvent(AssetEvent.DOWNLOADCOMPLETE);
				Notify.Id = Lib.Id;
				dispatchEvent(Notify);
			}
		}
	}
	
	/**
	 * 队列全部完成
	 **/
	private function OnQueueDownloadComplete(event:BatchDownloadEvent):void
	{
		_DownloadProcess = false;
		_DownloadAssetLibQueue = new Vector.<IAssetLibrary>();
		_DownloadUrlQueue = new Vector.<String>();
		if(_WaitQueue.length > 0)
		{
			_DownloadAssetLibQueue = _DownloadAssetLibQueue.concat(_WaitQueue);
			_WaitQueue = new Vector.<IAssetLibrary>();
			StartDownload();
		}
		else
		{
			var Notify:AssetEvent = new AssetEvent(AssetEvent.BATCHDOWNLOADCOMPLETE);
			dispatchEvent(Notify);
		}
	}
	
	//依据名称获取资源库
	public function FindAssetLibraryById(Id:String):IAssetLibrary
	{
		return _DownloadedAssetLibrary[Id];
	}
}