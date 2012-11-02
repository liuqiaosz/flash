package game.sdk.map.tile
{
	public class StaggeredTile extends GenericTile
	{
		public function StaggeredTile(Row:int = 0,Column:int = 0,Size:int = 0)
		{
			super(Row,Column,Size);
		}
		
		/**
		 * 绘制菱形
		 **/
		override protected function DrawDiamond():void
		{
			graphics.moveTo(0, TileSize * .5);
			graphics.lineTo(TileSize,0);
			graphics.lineTo(TileSize * 2,TileSize * .5);
			graphics.lineTo(TileSize,TileSize);
			graphics.lineTo(0, TileSize * .5);
		}
	}
}