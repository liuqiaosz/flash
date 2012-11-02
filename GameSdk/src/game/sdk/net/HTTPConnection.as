package game.sdk.net
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.sdk.net.event.NetEvent;
	import game.sdk.net.event.NetProgressEvent;

	/**
	 * HTTP连接
	 **/
	public class HTTPConnection extends EventDispatcher implements IHTTPConnection
	{
		//连接URL
		private var _Url:String = "";
		//连接
		private var _Connection:URLRequest = null;
		
		protected var _Loader:URLLoader = null;

		protected var _Format:String = NetDataFormat.HTTP_TEXT;
		
		protected var _Process:Boolean = false;
		
		public function HTTPConnection(Url:String = "")
		{
			_Url = Url;	
		}
		
		public function set URL(Value:String):void
		{
			_Url = Value;
			_Connection = new URLRequest(_Url);
		}
		public function get URL():String
		{
			return _Url;
		}
		
		public function Connect(Url:String):void
		{
			_Url = Url;
			_Connection = new URLRequest(_Url);
		}
		public function Close():void
		{
			_Loader.removeEventListener(IOErrorEvent.IO_ERROR,OnIoError);
			_Loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,OnSecurityError);
			_Loader.removeEventListener(Event.COMPLETE,OnComplete);
			_Loader.removeEventListener(ProgressEvent.PROGRESS,OnProgress);
		}
		
		public function set Format(Value:String):void
		{
			_Format = Value;
		}
		
		/**
		 * 数据请求
		 **/
		public function Request(Attr:IAttribute = null):void
		{
			if(!_Process)
			{
				if(null == _Loader)
				{
					_Loader = new URLLoader();
					
					
					_Loader.addEventListener(IOErrorEvent.IO_ERROR,OnIoError);
					_Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,OnSecurityError);
					_Loader.addEventListener(Event.COMPLETE,OnComplete);
					_Loader.addEventListener(ProgressEvent.PROGRESS,OnProgress);
				}
				switch(_Format)
				{
					case NetDataFormat.HTTP_BINARY:
						_Loader.dataFormat = URLLoaderDataFormat.BINARY;
						break;
					//					case NetDataFormat.HTTP_IMAGE_JPG:
					//						_Loader.dataFormat = URLLoaderDataFormat.BINARY;
					//						break;
					//					case NetDataFormat.HTTP_IMAGE_PNG:
					//						_Loader.dataFormat = URLLoaderDataFormat.BINARY;
					//						break;
					//					case NetDataFormat.HTTP_SWF:
					//						_Loader.dataFormat = URLLoaderDataFormat.BINARY;
					//						break;
					default:
						_Loader.dataFormat = _Format;
				}
				_Connection = new URLRequest(_Url);
				_Loader.load(_Connection);
				_Process = true;
			}
			if(Attr)
			{
				_Connection.data = Attr.GetPakcage();
			}

			
			//this.load(_Connection);
		}
		
		/**
		 * IO异常
		 **/
		protected function OnIoError(event:IOErrorEvent):void
		{
			var Notify:NetEvent = new NetEvent(NetEvent.NET_IOERROR);
			Notify.Message = event.text;
			dispatchEvent(Notify);
			_Process = false;
		}
		
		/**
		 * 安全异常
		 **/
		protected function OnSecurityError(event:SecurityErrorEvent):void
		{
			var Notify:NetEvent = new NetEvent(NetEvent.NET_SECURITYERROR);
			Notify.Message = event.text;
			dispatchEvent(Notify);
			_Process = false;
		}
		
		/**
		 * 加载中
		 **/
		protected function OnProgress(event:ProgressEvent):void
		{
			var Notify:NetProgressEvent = new NetProgressEvent(NetProgressEvent.NET_PROGRESS);
			Notify.Loaded = event.bytesLoaded;
			Notify.Total = event.bytesTotal;
			dispatchEvent(Notify);
		}
		
		/**
		 * 成功
		 **/
		protected function OnComplete(event:Event):void
		{
			var Notify:NetEvent = new NetEvent(NetEvent.NET_COMPLETE);
			switch(_Format)
			{
//				case NetDataFormat.HTTP_SWF:
//					HttpByteLoad();
//					return;
//				case NetDataFormat.HTTP_IMAGE_JPG:
//					HttpByteLoad();
//					return;
//				case NetDataFormat.HTTP_IMAGE_PNG:
//					HttpByteLoad();
//					return;
				case NetDataFormat.HTTP_BINARY:
					var Source:ByteArray = URLLoader(_Loader).data as ByteArray;
					if(Source)
					{
						var Binary:ByteArray = new ByteArray();
						Binary.writeBytes(Source,0,Source.length);
						Binary.position = 0;
						Notify.Binary = Binary;
					}
					
					break;
				default:
					Notify.Message = URLLoader(_Loader).data as String;
			}
			dispatchEvent(Notify);
			_Process = false;
		}
		
//		/**
//		 * SWF.图片数据二次加载
//		 **/
//		protected function HttpByteLoad():void
//		{
//			var ByteLoade:Loader = new Loader();
//			ByteLoade.contentLoaderInfo.addEventListener(Event.COMPLETE,ByteLoadComplete);
//			ByteLoade.loadBytes(_Loader.data);
//		}
//		
//		/**
//		 * SWF.图片下载数据加载完成
//		 **/
//		protected function ByteLoadComplete(event:Event):void
//		{
//			var ByteLoader:LoaderInfo = LoaderInfo(event.currentTarget);
//			var Notify:NetEvent = new NetEvent(NetEvent.NET_COMPLETE);
//			switch(_Format)
//			{
//				case NetDataFormat.HTTP_SWF:
//					var Swf:Object = ByteLoader.content;
//					Notify.Swf = Swf;
//					break;
//				case NetDataFormat.HTTP_IMAGE_JPG:
//					Notify.Image = ByteLoader.content as Bitmap;
//					break;
//				case NetDataFormat.HTTP_IMAGE_PNG:
//					Notify.Image = ByteLoader.content as Bitmap;
//					break;
//			}
//			dispatchEvent(Notify);
//		}
	}
}