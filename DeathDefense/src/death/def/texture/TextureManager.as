package death.def.texture
{
	public class TextureManager
	{
		private static var _instance:ITextureManager = null;
		public function TextureManager()
		{
		}
		
		public static function get instance():ITextureManager
		{
			return _instance;
		}
	}
}
import death.def.texture.ITextureManager;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import pixel.texture.vo.PixelTexture;
import pixel.texture.vo.PixelTexturePackage;

class TextureManagerImpl extends EventDispatcher implements ITextureManager
{
	private var _loader:URLLoader = null;
	private var _waitQueue:Vector.<String> = null;
	private var _loading:Boolean = false;
	public function TextureManagerImpl()
	{
		_waitQueue = new Vector.<String>();
		_loader = new URLLoader();
		_loader.dataFormat = URLLoaderDataFormat.BINARY;
		_loader.addEventListener(Event.COMPLETE,eventOnComplete);
	}
	private function eventOnComplete(event:Event):void
	{
		if(_waitQueue.length == 0)
		{
			_loading = false;
			var data:ByteArray = new ByteArray();
			ByteArray(_loader.data).readBytes(data,0,ByteArray(_loader.data).length);
		}
		startDownload();
	}
	
	private function startDownload():void
	{
		if(_waitQueue.length > 0)
		{
			_loading = true;
			_loader.load(new URLRequest(_waitQueue.pop()));
		}
	}
	
	public function download(url:String):void
	{
		_waitQueue.push(url);
		if(!_loading)
		{
			startDownload();
		}
	}
	
	public function findTextureById(id:String):PixelTexture
	{
		return null;
	}
	public function findTexturePackageById(id:String):PixelTexturePackage
	{
		return null;
	}
}