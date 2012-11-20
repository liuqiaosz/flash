package pixel.assets
{
	/**
	 * 资源管理器接口
	 * 
	 * 
	 **/
	public interface IPixelAssetsManager
	{
		function changeHandler(handler:Class):void;
		function get loader():IPixelAssetsMarshal;
	}
}