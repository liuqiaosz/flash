package game.sdk.map.layer
{
	import game.sdk.core.IRender;

	public interface ILayer extends IRender
	{
		function LayerUpdate(Row:int,Column:int,TileWidth:int,TileHeight:int):void;
	}
}