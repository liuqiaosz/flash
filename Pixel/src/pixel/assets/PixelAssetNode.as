package pixel.assets
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import pixel.core.PixelNs;
	
	use namespace PixelNs;
	
	/**
	 * Loader封装，提供一些便利接口
	 * 
	 * 
	 */
	public class PixelAssetNode extends EventDispatcher
	{
		private var _loader:Loader = null;
		private var _url:String = "";
		private var _loaded:Boolean = false;
		public function PixelAssetNode(url:String)
		{
			_url = url;
		}
		
		PixelNs function load():void
		{
			if(null == _loader)
			{
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loadProgress);
			}
			
			_loader.load(new URLRequest(_url));
		}
		
		private var _mark:int = 0;
		PixelNs function mark():void
		{
			_mark = flash.utils.getTimer();
		}
		PixelNs function getMark():int
		{
			return _mark;
		}
		
		public function getDefinition(className:String):Object
		{
			if(_loaded)
			{
				if(_loader.contentLoaderInfo.applicationDomain.hasDefinition(className))
				{
					return _loader.contentLoaderInfo.applicationDomain.getDefinition(className);
				}
			}
			return null;
		}
		
		public function getDefinitionNames():Vector.<String>
		{
			if(_loaded)
			{
				return _loader.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
			}
			return null;
		}
		
		/**
		 *
		 * 
		 * 释放资源
		 */
		public function dispose():void
		{
			if(_loaded)
			{
				_loader.unload();
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				_loader = null;
			}
		}
		
		
		
		private function loadComplete(event:Event):void
		{
			_loaded = true;
		}
		private function loadError(event:IOErrorEvent):void
		{}
		private function loadProgress(event:ProgressEvent):void
		{}
		
	}
}