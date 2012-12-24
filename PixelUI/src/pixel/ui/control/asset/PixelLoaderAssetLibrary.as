package pixel.ui.control.asset
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.utils.ByteArray;
	
	import pixel.utility.System;

	public class PixelLoaderAssetLibrary extends AssetLibrary
	{
		private var _initialized:Boolean = false;
		private var _loader:Loader = null;
		
		public function PixelLoaderAssetLibrary(loader:Loader,id:String)
		{
			super(id);
			_loader = loader;
			var array:Vector.<String> = _loader.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
			for each(var name:String in array)
			{
				var clas:Object = _loader.contentLoaderInfo.applicationDomain.getDefinition(name);
				var value:Object = new clas();
				
				if(value is Bitmap || value is BitmapData)
				{
					var img:Bitmap = value is Bitmap ? value as Bitmap:new Bitmap(value as BitmapData);
					var image:AssetImage = new AssetImage(name,img);
					//_BitmapAssets.push(AssetImage);
					addAsset(image);
				}
			}
		}
	}
}