package game.sdk.scene
{
	import flash.utils.ByteArray;
	
	import game.sdk.map.tile.TileData;
	
	import utility.IDispose;

	public interface IScene extends IDispose
	{
		function Initializer(Model:ByteArray):void;
		function get Name():String;
	}
}