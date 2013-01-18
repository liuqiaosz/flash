package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class Sample extends Sprite
	{
		private var _domain:ApplicationDomain = null;
		private var read:Reader = null;
		private var childReader:Reader = null;
		//private var vec:Vector.<Loader> = new Vector.<Loader>();
		private var mod:SceneModule = null;
		//private var cache:Dictionary = new Dictionary();
		private var s:Sprite = null;
		public function Sample()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,function(event:KeyboardEvent):void{
				if(event.keyCode == Keyboard.SPACE)
				{
					mod = new SceneModule();
					mod.sceneDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
					read = new Reader(complete);
					var ctx:LoaderContext = new LoaderContext();
					ctx.applicationDomain = mod.sceneDomain;
					//read.load("login.swf",ctx);
					read.load("UI.swf",ctx);
				}
				if(event.keyCode == Keyboard.A)
				{
					//mod.clear();
					//_domain = null;
					//var lod:Loader = null;
					//read.unload();
					_img.bitmapData.dispose();
					_img = null;
					read = null;
					childReader = null;
					mod.clear();
					trace("clear");
					
				}
				
				if(event.keyCode == Keyboard.ENTER)
				{
					traceDomain();
				}
			});
			
			
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
			
				
			});
			
			s = new Sprite();
			addChild(s);
			
			var s1:Sprite = new Sprite();
			s.addChild(s1);
		}
		private var _img:Bitmap = null;
		private function complete(loader:Loader):void
		{
			mod.library.push(loader);
			childReader = new Reader(function(load:Loader):void{
				traceDomain();
				var src:Object = mod.sceneDomain.getDefinition("login007");
				_img = new Bitmap(new src() as BitmapData);
				
				mod.library.push(load);
				
				var login:Reader = new Reader(function(loginLoader:Loader):void{
					mod.sceneContent = loginLoader;
				});
				var c:LoaderContext = new LoaderContext();
				c.applicationDomain = mod.sceneDomain;
				login.load("bleach/scene/LoginScene.swf",c);
			});
			var ctx:LoaderContext = new LoaderContext();
			ctx.applicationDomain = mod.sceneDomain;
			childReader.load("login.swf",ctx);
		}
		
		private function traceDomain():void
		{
			var names:Vector.<String> = mod.sceneDomain.getQualifiedDefinitionNames();
			for each(var name:String in names)
			{
				trace(name);
			}
		}
	}
}

import flash.display.Loader;
import flash.display.Scene;
import flash.system.ApplicationDomain;

class SceneModule
{
	private var _sceneContent:Loader = null;
	public function set sceneContent(value:Loader):void
	{
		_sceneContent = value;
	}
	public function get sceneContent():Loader
	{
		return _sceneContent;
	}
	private var _loaded:Boolean = false;
	public function get loaded():Boolean
	{
		return _loaded;
	}
	public function set loaded(value:Boolean):void
	{
		_loaded = value;
	}
	private var _domain:ApplicationDomain = null;
	public function get sceneDomain():ApplicationDomain
	{
		return _domain;
	}
	public function set sceneDomain(value:ApplicationDomain):void
	{
		_domain = value;
	}
	public function SceneModule()
	{
		_library = new Vector.<Loader>();
	}
	
	private var _library:Vector.<Loader> = null;
	//	public function addLibrary(value:Loader):void
	//	{
	//		_library.push(value);
	//	}
	
	public function set library(value:Vector.<Loader>):void
	{
		_library = value;
		_loaded = true;
	}
	public function get library():Vector.<Loader>
	{
		return _library;
	}
	
	public function clear():void
	{
		if(_sceneContent)
		{
			_sceneContent.unloadAndStop(true);
			_sceneContent = null;
		}
		var loader:Loader = null;
		while(_library.length > 0)
		{
			loader = _library.pop();
			loader.unloadAndStop();
			loader = null;
		}
		_library = null;
		_domain = null;
		_loaded = false;
	}
}

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.LoaderContext;

class Reader 
{
	private var _call:Function = null;
	private var _loader:Loader = null;
	public function Reader(callback:Function)
	{
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
		_call = callback;
	}
	
	private function complete(event:Event):void
	{
		_call(_loader);
	}
	
	public function load(url:String,ctx:LoaderContext = null):void
	{
		_loader.load(new URLRequest(url),ctx);
	}
	
	public function unload():void
	{
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,complete);
		_loader.unloadAndStop(true);
		_loader = null;
		_call = null;
	}
}