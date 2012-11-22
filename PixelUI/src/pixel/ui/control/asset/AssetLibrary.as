package pixel.ui.control.asset
{
	import flash.utils.Dictionary;
	
	import pixel.ui.core.LibraryInternal;

	use namespace LibraryInternal;
	
	public class AssetLibrary implements IAssetLibrary
	{
		private var _assets:Vector.<IAsset> = null;
		private var _assetsMap:Dictionary = null;
		
		private var _id:String = "";
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		
		public function AssetLibrary(id:String = "")
		{
			_assets = new Vector.<IAsset>();
			_assetsMap = new Dictionary();
			_id = id;
		}
		
		public function addAsset(asset:IAsset):void
		{
			_assets.push(asset);
			_assetsMap[asset.name] = asset;
		}
		
		public function get assets():Vector.<IAsset>
		{
			return _assets;
		}
		
		public function hasDefinition(name:String):Boolean
		{
			return (name in _assetsMap);
		}
		
		public function findAssetByName(name:String):IAsset
		{
			if(name in _assetsMap)
			{
				return _assetsMap[name];
			}
			return null;
		}
	}
}