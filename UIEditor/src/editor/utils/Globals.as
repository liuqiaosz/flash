package editor.utils
{
	import flash.utils.Dictionary;
	
	import pixel.ui.control.asset.IAsset;
	import pixel.ui.control.asset.IAssetLibrary;


	public class Globals
	{
		private static var _AssetLibrarys:Dictionary = new Dictionary();
		
		public static function AppendAssetLibrary(Library:IAssetLibrary):void
		{
			_AssetLibrarys[Library.id] = Library;
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
		
		public static function FindAssetById(LibraryId:String,AssetId:String):IAsset
		{
			var Library:IAssetLibrary = FindAssetLibraryById(LibraryId);
			
			if(Library)
			{
				return Library.findAssetByName(AssetId);
				
			}
			return null;
		}
		
		public static function FindAssetByAssetId(Id:String):IAsset
		{
			var Library:IAssetLibrary = null;
			
			for each(Library in _AssetLibrarys)
			{
				if(Library.hasDefinition(Id))
				{
					return Library.findAssetByName(Id);
				}
			}
			return null;
		}
	}
}