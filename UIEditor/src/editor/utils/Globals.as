package editor.utils
{
	import editor.model.asset.Asset;
	import editor.model.asset.IAssetLibrary;
	
	import flash.utils.Dictionary;
	
	import mx.core.IAssetLayoutFeatures;

	public class Globals
	{
		private static var _AssetLibrarys:Dictionary = new Dictionary();
		
		public static function AppendAssetLibrary(Library:IAssetLibrary):void
		{
			_AssetLibrarys[Library.Id] = Library;
		}
		
		public static function FindAssetLibraryById(Id:String):IAssetLibrary
		{
			if(_AssetLibrarys.hasOwnProperty(Id))
			{
				return _AssetLibrarys[Id];
			}
			return null;
		}
		
		public static function Clear():void
		{
			_AssetLibrarys = new Dictionary();
		}
		public function Globals()
		{
		}
		
		public static function FindAssetById(LibraryId:String,AssetId:String):Asset
		{
			var Library:IAssetLibrary = FindAssetLibraryById(LibraryId);
			
			if(Library)
			{
				return Library.FindAssetById(AssetId);
			}
			return null;
		}
		
		public static function FindAssetByAssetId(Id:String):Asset
		{
			var Library:IAssetLibrary = null;
			
			for each(Library in _AssetLibrarys)
			{
				if(Library.ContainId(Id))
				{
					return Library.FindAssetById(Id);
				}
			}
			return null;
		}
	}
}