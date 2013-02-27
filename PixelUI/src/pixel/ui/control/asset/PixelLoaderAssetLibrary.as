package pixel.ui.control.asset
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.utils.ByteArray;
	
	import pixel.utility.System;

	public class PixelLoaderAssetLibrary extends AssetLibrary
	{
		private var _keySet:Vector.<String> = null;
		private var _initialized:Boolean = false;
		private var _loader:Loader = null;
		
		public function PixelLoaderAssetLibrary(loader:Loader,id:String,keySet:Vector.<String> = null)
		{
			super(id);
			_loader = loader;
			_keySet = keySet;
			//var array:Vector.<String> = _loader.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
			if(_keySet)
			{
				for each(var name:String in _keySet)
				{
					var clas:Object = _loader.contentLoaderInfo.applicationDomain.getDefinition(name);
					var value:Object = new clas();
					
					if(value is Bitmap || value is BitmapData)
					{
						var img:Bitmap = value is Bitmap ? value as Bitmap:new Bitmap(value as BitmapData);
						var image:AssetImage = new AssetImage(name,img);
						addAsset(image);
					}
				}
			}
			
		}
		
		override public function hasDefinition(name:String):Boolean
		{
			if(name in _assetsMap)
			{
				return true;
			}
			return _loader.contentLoaderInfo.applicationDomain.hasDefinition(name);
		}
		
		override public function findAssetByName(name:String):IAsset
		{
			var _asset:IAsset = super.findAssetByName(name);
			if(_asset)
			{
				return _asset;
			}
			if(_loader.contentLoaderInfo.applicationDomain.hasDefinition(name))
			{
				var clas:Object = _loader.contentLoaderInfo.applicationDomain.getDefinition(name);
				var value:Object = new clas();
				if(value is Bitmap || value is BitmapData)
				{
					var img:Bitmap = value is Bitmap ? value as Bitmap:new Bitmap(value as BitmapData);
					var image:AssetImage = new AssetImage(name,img);
					addAsset(image);
					return image;
				}
			}
			return null;
		}
		
		override public function unload():void
		{
			_loader.unloadAndStop(true);
			_loader = null;
		}
	}
}