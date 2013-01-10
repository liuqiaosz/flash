package death.def.module.loader
{
	import death.def.utils.Constants;
	import death.def.utils.ShareDisk;
	import death.def.utils.ShareObjectHelper;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	/**
	 * 加载器
	 * 
	 * 1: 加载全局配置
	 * 
	 * 2: 加载全局纹理
	 * 
	 * 3: 加载动态库
	 * 
	 * 4: 加载主程序
	 * 
	 * 
	 * 
	 **/
	[SWF(width="1280",height="600",backgroundColor="0xFFFFFF")]
	public class BleachLoader extends Sprite
	{
		private var _loader:Loader = null;
		public function BleachLoader()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
		}
		
		private function onLoadProgress(event:ProgressEvent):void
		{
			var percent:int = (event.bytesLoaded / event.bytesTotal * 100);
			addLog("加载进度[" + percent + "%] Total[" + event.bytesTotal + "] Loaded[" + event.bytesLoaded + "]");
		}
		
		private var _label:TextField = null;
		private function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			_label = new TextField();
			_label.selectable = false;
			_label.multiline = true;
			_label.width = 500;
			_label.height = 200;
			_label.border = true;
			
			addChild(_label);
			loadConfig();
		}
		
		private function loadConfig():void
		{
			addLog("开始下载配置数据");
			var conn:URLLoader = new URLLoader();
			conn.dataFormat = URLLoaderDataFormat.BINARY;
			conn.addEventListener(Event.COMPLETE,configComplete);
			
			//var url:URLRequest = new URLRequest("http://localhost:8084/bleach/service/" + new Date().time);
			var url:URLRequest = new URLRequest("http://localhost:8084/bleach/service/");
			var header:URLRequestHeader = new URLRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
			url.method = "POST";
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes("0003002");
			url.data = data;
			conn.load(url);
		}
		
		/**
		 * 配置下载完毕
		 **/
		private function configComplete(event:Event):void
		{
			var localCfg:ShareDisk = ShareObjectHelper.findShareDisk(Constants.KEY_LOCALCFG);
			addLog("配置下载完毕");
			var conn:URLLoader = event.target as URLLoader;
			var data:ByteArray = conn.data as ByteArray;
			
			if(!data)
			{
				//异常！！
			}
			data.readUTFBytes(4);
			data.readUTFBytes(3);
			data.readUTFBytes(4);
			//获取服务端最新配置
			var appVer:String = data.readUTFBytes(3);
			var rslVer:String = data.readUTFBytes(3);
			var msgVer:String = data.readUTFBytes(3);
			
			addLog("最新主程序版本[" + appVer + "]");
			addLog("最新共享库版本[" + rslVer + "]");
			addLog("最新消息库版本[" + msgVer + "]");
			//addLog(data.readUTFBytes(data.bytesAvailable));
		}
		
		private function loadLibrary():void
		{
			_loader = new Loader();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				var vec:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
				for each(var v:String in vec)
				{
					trace(v);
				}
				//var cls:Object = ApplicationDomain.currentDomain.getDefinition("pixel.ui.control.UIButton");
				//var btn:UIButton = new cls() as UIButton;
				loader = new Loader();
				
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
				//loader.load(new URLRequest("/Users/LiuQiao/Documents/Developer/Code/flash/DeathDefense/bin-debug/death/def/module/message/MsgLibrary.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event2:Event):void{
					//addChild(loader);
					var vec:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
					for each(var v:String in vec)
					{
						trace(v);
					}
				});
				addLog("开始加载主程序");
				loader.load(new URLRequest("BleachDefense.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
			});
			var ctx:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			
			loader.load(new URLRequest("/Users/LiuQiao/Documents/Developer/Code/flash/BleachLibrary/bin-debug/BleachLibrary.swf"),ctx);
			addLog("开始加载共享库...");
		}
		
		private function addLog(value:String):void
		{
			_label.appendText(value + "\n");
		}
	}
}
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.utils.Dictionary;

/**
 * 共享库更新下载器
 **/
class LibraryDownloader extends EventDispatcher
{
	private var taskQueue:Vector.<Task> = null;
	public function LibraryDownloader()
	{
		taskQueue = new Vector.<Task>();
	}
	
	/**
	 * 添加下载任务
	 * 
	 * @param	url			下载URL
	 * @param	callback	通知回调
	 **/
	public function addTask(url:String,callback:Function):void
	{
		taskQueue.push(new Task(url,callback));
	}
	
	public function start():void
	{
		
	}
	
	private var task:Task = null;
	private function download():void
	{
		if(taskQueue.length > 0)
		{
			task = taskQueue.shift();
			if(task)
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			}
		}
	}
	
	private function onComplete(event:Event):void
	{
		if(task)
		{
			task.callback(event.target as Loader);
		}
		download();
	}
	private function onProgress(event:ProgressEvent):void
	{
		dispatchEvent(event);
	}
	private function onError(event:Event):void
	{
		dispatchEvent(event);
	}
}

class Task
{
	private var _url:String = "";
	public function set url(value:String):void
	{
		_url = value;
	}
	public function get url():String
	{
		return _url;
	}
	
	private var _callback:Function = null;
	public function get callback():Function
	{
		return _callback;
	}
	
	public function Task(url:String,callback:Function)
	{
		_url = url;
		_callback = callback;
	}
}