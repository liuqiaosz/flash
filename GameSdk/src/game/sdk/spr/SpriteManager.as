package game.sdk.spr
{
	public class SpriteManager
	{
		private static var _Instance:ISpriteManager = null;
		public function SpriteManager()
		{
		}
		
		public static function get Instance():ISpriteManager
		{
			if(_Instance == null)
			{
				_Instance = new SpriteManagerImpl();
			}
			
			return _Instance;
		}
	}
}

import flash.sensors.Accelerometer;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import game.sdk.net.ConnectionManager;
import game.sdk.net.IDownloader;
import game.sdk.net.event.DownloadEvent;
import game.sdk.spr.ISpriteManager;
import game.sdk.spr.ISpriteSheet;
import game.sdk.spr.ISpriteSheetPack;
import game.sdk.spr.SpriteSheet;
import game.sdk.spr.SpriteSheetMode;
import game.sdk.spr.SpriteSheetPack;

class SpriteManagerImpl implements ISpriteManager
{
	private var Downloader:IDownloader = null;
	private var _SheetDictionary:Dictionary = null;
	public function SpriteManagerImpl()
	{
		_SheetDictionary = new Dictionary();
	}
	
	public function Download(NavURL:String):void
	{
		if(null == Downloader)
		{
			Downloader = ConnectionManager.GetBinaryDownloader();
			Downloader.addEventListener(DownloadEvent.DOWNLOAD_COMPLETE,DownloadComplete);
		}
		Downloader.Download(NavURL);
	}
	
	/**
	 * 下载完成
	 **/
	protected function DownloadComplete(event:DownloadEvent):void
	{
		var Data:ByteArray = event.Data as ByteArray;
		var Mode:uint = Data.readByte();
		
		switch(Mode)
		{
			case SpriteSheetMode.SHEET:
				//序列
				var Sheet:ISpriteSheet = new SpriteSheet();
				Sheet.Decode(Data);
				_SheetDictionary[Sheet.Id] = Sheet;
				break;
			case SpriteSheetMode.SHEETPACK:
				//序列包
				var Pack:ISpriteSheetPack = new SpriteSheetPack();
				Pack.Decode(Data);
				_SheetDictionary[Pack.PackId] = Pack;
				break;
		}
	}
	
	public function FindSpriteSheetOnGroup(GroupId:String,Id:String):ISpriteSheet
	{
		var Group:ISpriteSheetPack = _SheetDictionary[GroupId] as ISpriteSheetPack;
		if(Group)
		{
			return Group.FindSheetById(Id);
		}
		return null;
	}
	
	public function FindSpriteSheetById(Id:String):ISpriteSheet
	{
		var Value:ISpriteSheet = _SheetDictionary[Id] as ISpriteSheet;
		return Value;
	}
}