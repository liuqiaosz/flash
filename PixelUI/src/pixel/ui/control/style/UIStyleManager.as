package pixel.ui.control.style
{
	public class UIStyleManager
	{
		private static var _instance:IUIStyleManager = null;
		public function UIStyleManager()
		{
		}
		
		public static function get instance():IUIStyleManager
		{
			if(!_instance)
			{
				_instance = new UIStyleManagerImpl();
			}
			return _instance;
		}
	}
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import pixel.ui.control.event.PixelUIEvent;
import pixel.ui.control.style.IUIStyleManager;
import pixel.ui.control.style.IVisualStyle;
import pixel.ui.control.style.UIStyleFactory;
import pixel.ui.control.vo.UIStyleGroup;
import pixel.ui.control.vo.UIStyleMod;

class UIStyleManagerImpl extends EventDispatcher implements IUIStyleManager
{
	private var _cache:Vector.<UIStyleGroup> = null;
	private var _loader:URLLoader = null;
	private var _queue:Vector.<String> = null;
	private var _loading:Boolean = false;
	public function UIStyleManagerImpl()
	{
		_queue = new Vector.<String>();
		_cache = new Vector.<UIStyleGroup>();
		_loader = new URLLoader();
		_loader.addEventListener(Event.COMPLETE,loadComplete);
		_loader.dataFormat = URLLoaderDataFormat.BINARY;
	}
	
	public function download(url:String):void
	{
		_queue.push(url);
		startLoad();
	}
	
	public function downloadQueue(queue:Vector.<String>):void
	{
		_queue = _queue.concat(queue);
		startLoad();
	}
	
	private function startLoad():void
	{
		if(!_loading)
		{
			var url:String = _queue.shift();
			_loading = true;
			_loader.load(new URLRequest(url));
		}
	}
	
	private function loadComplete(event:Event):void
	{
		var data:ByteArray = _loader.data as ByteArray;
		var notify:PixelUIEvent = new PixelUIEvent(PixelUIEvent.STYLE_DONWLOAD_COMPLETE);
		notify.value = UIStyleFactory.instance.groupDecode(data);
		dispatchEvent(notify);
		
		if(_queue.length > 0)
		{
			//继续下载
			var url:String = _queue.shift();
			_loader.load(new URLRequest(url));
		}
		else
		{
			_loading = false;
		}
	}
	
	public function findStyleById(id:String):UIStyleMod
	{
		var group:UIStyleGroup = null;
		for each(group in _cache)
		{
			if(group.containStyle(id))
			{
				return group.findStyleById(id);
			}
		}
		return null;
	}
	
	public function get styles():Vector.<UIStyleGroup>
	{
		return _cache;
	}
	
	public function addStyle(style:UIStyleGroup):void
	{
		_cache.push(style);
	}
	public function clearCache():void
	{
		_cache.length = 0;
	}
}