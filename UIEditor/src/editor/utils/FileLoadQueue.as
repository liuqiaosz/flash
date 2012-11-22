package editor.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;

	/**
	 * 文件队列加载工具类
	 **/
	public class FileLoadQueue
	{
		private var _Files:Array = [];
		private var _CurrentFile:File = null;
		private var _Extension:String = null;
		private var _SuccessCallback:Function = null;
		private var _FailureCallback:Function = null;
		private var _Total:int = 0;
		private var _Current:int = 0;
		
		public function FileLoadQueue(FileList:Array,Extension:String = null)
		{
			_Extension = Extension;
			//_Files = FileList;
			for(var Idx:int=0; Idx<FileList.length; Idx++)
			{
				_Files.push(new FileMask(FileList[Idx]));
			}
			_Total = _Files.length;
			_Files.sortOn("CreateDate",Array.NUMERIC);
		}
		
		public function Start(SuccessCallback:Function = null,FailureCallback:Function = null):void
		{
			this._SuccessCallback = SuccessCallback;
			this._FailureCallback = FailureCallback;
			if(_Total > 0)
			{
				LoadFile();
			}
		}
		
		private function LoadFailure(event:Event):void
		{
			if(_FailureCallback != null)
			{
				_FailureCallback(_CurrentFile);
			}
		}
		private function LoadComplete(event:Event):void
		{
			_CurrentFile.removeEventListener(Event.COMPLETE,LoadComplete);
			_CurrentFile.removeEventListener(IOErrorEvent.IO_ERROR,LoadFailure);
			if(_SuccessCallback != null)
			{
				_SuccessCallback(_CurrentFile,_CurrentFile.data);
			}
			_Current++;
			if(_Current < _Total)
			{
				LoadFile();
			}
		}
		
		private function LoadFile():void
		{
			_CurrentFile = _Files[_Current].FileSource;
			if(_Extension != null)
			{
				var ext:String = _CurrentFile.nativePath.substring(_CurrentFile.nativePath.lastIndexOf("." + 1));
				if(ext == _Extension)
				{
					_CurrentFile.addEventListener(Event.COMPLETE,LoadComplete);
					_CurrentFile.addEventListener(IOErrorEvent.IO_ERROR,LoadFailure);
					_CurrentFile.load();
				}
			}
			else
			{
				if(_Current < _Total)
				{
					_Current++;
					LoadFile();
				}
			}
		}
	}
}
import flash.filesystem.File;

class FileMask
{
	private var _File:File = null;
	public function get FileSource():File
	{
		return _File;
	}
	public function FileMask(Source:File)
	{
		_File = Source;
	}
	
	public function get extension():String
	{
		
		return _File.nativePath.substring(_File.nativePath.lastIndexOf("." + 1));
	}
	public function get CreateDate():Number
	{
		return _File.creationDate.time;
	}
}