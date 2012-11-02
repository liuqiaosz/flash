package editor.model.asset
{
	/**
	 * 资产工厂
	 **/
	public class AssetFactory
	{
		private static var _Instance:AssetFactoryImpl = null;
		public function AssetFactory()
		{
		}
		
		public static function get Instance():IAssetFactory
		{
			if(null == _Instance)
			{
				_Instance = new AssetFactoryImpl();
			}
			
			return _Instance;
		}
	}
}

import editor.model.asset.AssetLibrary;
import editor.model.asset.IAssetFactory;
import editor.model.asset.IAssetLibrary;
import editor.model.asset.SwfAssetLibrary;
import editor.utils.Common;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.dns.AAAARecord;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.utils.UIDUtil;

import utility.Tools;

class AssetFactoryImpl implements IAssetFactory
{
	public function AssetFactoryImpl()
	{
	}
	
	/**
	 * 创建新的资产库
	 **/
	public function CreateLibrary(Name:String):IAssetLibrary
	{
		var Library:AssetLibrary = new AssetLibrary();
		Library.Id = Tools.ReplaceAll(mx.utils.UIDUtil.createUID(),"-","");
		Library.Name = Name;
		SaveLibrary(Library);
		return Library;
	}
	
	/**
	 * 保存资产库
	 **/
	public function SaveLibrary(Library:IAssetLibrary):void
	{
		var AssetLibFile:File = new File(Common.ASSETLIB + Library.Id + Common.ASSL);
		var Writer:FileStream = new FileStream();
		try
		{
			Writer.open(AssetLibFile,FileMode.WRITE);
			var Data:ByteArray = Library.Encode();
			Data.position = 0;
			Writer.writeBytes(Data,0,Data.length);
			Writer.close();
		}
		catch(Err:Error)
		{
			trace(Err.message);
		}
		finally
		{
			if(Writer)
			{
				Writer.close();
			}
		}
	}
	
	/**
	 * 打开制定路径的资产库文件
	 **/
	public function OpenLibrary(Path:String):IAssetLibrary
	{
		var LibFile:File = new File(Path);
		var Lib:IAssetLibrary;
		var Reader:FileStream = null;
		var LibData:ByteArray = null;
		if(LibFile.exists && !LibFile.isDirectory && LibFile.extension == "assl")
		{
			Lib = new AssetLibrary();
			Reader = new FileStream();
			
			try
			{
				Reader.open(LibFile,FileMode.READ);
				LibData = new ByteArray();
				Reader.readBytes(LibData,0,Reader.bytesAvailable);
				//LibData.writeBytes(Reader.,0,Reader.bytesAvailable);
				LibData.position = 0;
				Lib.Decode(LibData);
				return Lib;
			}
			catch(Err:Error)
			{
				trace(Err.message);
			}
			finally
			{
				if(Reader)
				{
					Reader.close();
				}
			}	
		}
		else if(LibFile.exists && !LibFile.isDirectory && LibFile.extension == "swf")
		{
			Lib = new SwfAssetLibrary();
			Reader = new FileStream();
			try
			{
				Reader.open(LibFile,FileMode.READ);
				LibData = new ByteArray();
				Reader.readBytes(LibData,0,Reader.bytesAvailable);
				//LibData.writeBytes(Reader.,0,Reader.bytesAvailable);
				LibData.position = 0;
				Lib.Decode(LibData);
				Lib.Id = Lib.Name = LibFile.name.substring(0,LibFile.name.indexOf("."));
				return Lib;
			}
			catch(Err:Error)
			{
				trace(Err.message);
			}
			finally
			{
				if(Reader)
				{
					Reader.close();
				}
			}	
		}
		return null;
	}
}