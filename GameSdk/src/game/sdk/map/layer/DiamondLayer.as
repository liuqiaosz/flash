package game.sdk.map.layer
{
	import flash.events.Event;
	
	import game.sdk.event.GameEvent;
	import game.sdk.map.CoordinateTools;
	import game.sdk.map.tile.Position2D;
	import game.sdk.map.tile.TileData;

	public class DiamondLayer extends GenericLayer
	{
		public function DiamondLayer(Row:int,Column:int,TileSize:uint = 0)
		{
			super(Row,Column,TileSize * 2,TileSize);
		}
		
		override public function FindGridNodeByPostion(PosX:uint, PosY:uint):TileData
		{
			return null;
		}
		
		override public function Render():void
		{
			var tile:TileData = null;
			var pos:Position2D = null;
			this.graphics.clear();
			this.graphics.lineStyle(1);
			for each(tile in _GridQueue)
			{
				pos = tile.DiamondPosition;
				graphics.moveTo(pos.x - _GridTileHeight,pos.y);
				graphics.lineTo(pos.x,pos.y - _GridTileHeight / 2);
				graphics.lineTo(pos.x + _GridTileHeight,pos.y);
				graphics.lineTo(pos.x,pos.y + _GridTileHeight / 2);
				graphics.lineTo(pos.x - _GridTileHeight,pos.y);
			}
			dispatchEvent(new GameEvent(GameEvent.RENDER_OVER));
		}
	}
}