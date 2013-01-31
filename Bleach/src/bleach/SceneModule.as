package bleach
{
	import flash.display.Loader;
	import flash.display.Scene;
	import flash.system.ApplicationDomain;
	
	import pixel.ui.control.asset.PixelAssetManager;
	
	public class SceneModule
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
		private var _scene:SceneVO = null;
		public function get id():String
		{
			return _scene.id;
		}
		
		public function get scene():SceneVO
		{
			return _scene;
		}
		public function SceneModule(scene:SceneVO)
		{
			_scene = scene;
			//_library = new Vector.<Loader>(_scene.librarys.length);
		}
		
		private var _library:Vector.<Loader> = null;
		//	public function addLibrary(value:Loader):void
		//	{
		//		_library.push(value);
		//	}
		
		public function set library(value:Vector.<Loader>):void
		{
			_library = value;
		}
		public function get library():Vector.<Loader>
		{
			return _library;
		}
		
		public function clear():void
		{
			
			var loader:Loader = null;
			for(var idx:int=0; idx<_library.length; idx++)
			{
				loader = _library[idx];
				if(scene.librarys[idx].isUIlib)
				{
					PixelAssetManager.instance.removeAssetLibrary(scene.librarys[idx].id);
					
				}
				loader.unloadAndStop(true);
				loader = null;
			}
			if(_sceneContent)
			{
				_sceneContent.unloadAndStop(true);
				_sceneContent = null;
			}
			_library = null;
			_domain = null;
			_loaded = false;
		}
	}
}