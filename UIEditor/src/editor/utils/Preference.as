package editor.utils
{
	public class Preference
	{
		private static var _Instance:IPreference = null;
		public function Preference()
		{
			throw new Error("Singlton");
		}
		
		public static function get Instance():IPreference
		{
			if(null == _Instance)
			{
				_Instance = new PreferenceImpl();
			}
			
			return _Instance;
		}
	}
}
import editor.utils.Common;
import editor.utils.IPreference;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

import mx.controls.Alert;
import mx.messaging.messages.CommandMessage;

import utility.System;

class PreferenceImpl implements IPreference
{
	public function PreferenceImpl()
	{
		var PreferenceFile:File = new File(Common.INSTALL_DIR + Common.PREFERENCE);
		if(!PreferenceFile.exists)
		{
			FirstInitializer();
		}
		else
		{
			var Reader:FileStream = null;
			try
			{
				Reader = new FileStream();
				Reader.open(PreferenceFile,FileMode.READ);
				var Data:ByteArray = new ByteArray();
				Reader.readBytes(Data,0,Reader.bytesAvailable);
				Data.position = 0;
				
				var Os:int = Data.readByte();
				if(Os != System.SystemType)
				{
					//配置文件系统版本和当前运行系统版本不一致,重新初始化配置文件
					FirstInitializer();
					return;
				}
				
				var Len:uint = Data.readShort();
				_ScriptExport = Data.readUTFBytes(Len);
				Len = Data.readShort();
				_ModelExport = Data.readUTFBytes(Len);
				
				Len = Data.readShort();
				var Asset:String = Data.readUTFBytes(Len);
				_AssetPath = Asset.split("&");
				
				Len = Data.readShort();
				var Packages:String = Data.readUTFBytes(Len);
				_Packages = Packages.split("&");
			}
			catch(Err:Error)
			{
				Alert.show("操作异常，异常信息[" + Err.message + "]");
			}
			finally
			{
				if(Reader)
				{
					Reader.close();
					Reader = null;
				}
			}
		}
	}
	
	protected function FirstInitializer():void
	{
		var PreferenceFile:File = new File(Common.INSTALL_DIR + Common.PREFERENCE);
		var Writer:FileStream = null;
		try
		{
			Writer = new FileStream();
			Writer.open(PreferenceFile,FileMode.WRITE);
			var Value:String = Common.OUTPUT;
			
			//第一位写入标志为操作系统类型
			
			Writer.writeByte(System.SystemType);
			
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			
			Value = Common.MODEL;
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			
			Value = Common.ASSETLIB;
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			_AssetPath.push(Value);
			
			Value = Common.PACKAGE;
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			_Packages.push(Value);
			_ScriptExport = Common.OUTPUT;
			_ModelExport = Common.MODEL;
			
		}
		catch(Err:Error)
		{
			Alert.show("操作异常，异常信息[" + Err.message + "]");
		}
		finally
		{
			if(Writer)
			{
				Writer.close();
				Writer = null;
			}
		}
	}
	
	public function Save():void
	{
		UpdatePreference();
	}
	
	private function UpdatePreference():void
	{
		var PreferenceFile:File = new File(Common.INSTALL_DIR + Common.PREFERENCE);
		var Writer:FileStream = null;
		try
		{
			Writer = new FileStream();
			Writer.open(PreferenceFile,FileMode.WRITE);
			var Value:String = _ScriptExport;
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			
			Value = _ModelExport;
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			
			Value = "";
			for(var Idx:int=0; Idx<_AssetPath.length; Idx++)
			{
				Value += _AssetPath[Idx] + "&";
			}
			
			Value = Value.substr(0,Value.length - 1);
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
			
			Value = "";
			for(var j:int=0; j<_Packages.length; j++)
			{
				Value += _Packages[j] + "&";
			}
			
			Value = Value.substr(0,Value.length - 1);
			Writer.writeShort(Value.length);
			Writer.writeUTFBytes(Value);
		}
		catch(Err:Error)
		{
			Alert.show("操作异常，异常信息[" + Err.message + "]");
		}
		finally
		{
			if(Writer)
			{
				Writer.close();
				Writer = null;
			}
		}
	}
	
	private var _ScriptExport:String = "";
	public function get ScriptExport():String
	{
		return _ScriptExport;
	}
	public function set ScriptExport(Value:String):void
	{
		_ScriptExport = Value;
	}
	
	private var _ModelExport:String = "";
	public function get ModelExport():String
	{
		return _ModelExport;
	}
	
	public function set ModelExport(Value:String):void
	{
		_ModelExport = Value;
	}
	
	private var _AssetPath:Array = [];
	public function get AssetPath():Array
	{
		return _AssetPath;
	}
	public function AppendAssetPath(Value:String):void
	{
		_AssetPath.push(Value);
	}
	
	public function DeleteAssetPath(Value:String):void
	{
		if(_AssetPath.indexOf(Value) >= 0)
		{
			_AssetPath.splice(_AssetPath.indexOf(Value),1);
		}
	}
	
	//包路径处理函数
	public function AppendPackage(Value:String):void
	{
		_Packages.push(Value);
	}
	public function DeletePackage(Value:String):void
	{
		if(_Packages.indexOf(Value) >= 0)
		{
			_Packages.splice(_Packages.indexOf(Value),1);
		}
	}
	
	private var _Packages:Array = [];
	public function get Packages():Array
	{
		return _Packages;	
	}
}