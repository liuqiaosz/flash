package pixel.ui.control.asset
{
	public interface IAssetLibrary
	{
		function get id():String;
		/**
		 * 获取所有子项
		 */
		function get assets():Vector.<IAsset>;
		
		function hasDefinition(name:String):Boolean;
		
		function findAssetByName(name:String):IAsset;
		
		function unload():void;
	}
}