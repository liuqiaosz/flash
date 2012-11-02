package game.sdk.map.layer
{
	import flash.geom.Point;
	
	import game.sdk.map.CoordinateTools;
	import game.sdk.map.tile.TileData;

	/**
	 * 
	 * 
	 * 2.5D Staggered显示层
	 * 
	 **/
	public class StaggeredLayer extends GenericLayer
	{
		public function StaggeredLayer(Row:int,Column:int,TileSize:uint = 0)
		{
			super(Row,Column,TileSize * 2,TileSize);
		}
		
		/**
		 * 屏幕像素获取TileData
		 **/
		public function FindGridNodeByScreenPos(ScreenX:uint,ScreenY:uint):TileData
		{
			var Pos:Point = CoordinateTools.GetStaggeredTileByScreenPosition(this._GridTileWidth,_GridTileHeight,ScreenX + _GridTileHeight,ScreenY + (_GridTileHeight >> 1));
			return _Grid[Pos.y][Pos.x];
		}
		
//		override public function FindGridNodeByPostion(PosX:uint, PosY:uint):TileData
//		{
//			var Pos:Point = CoordinateTools.GetStaggeredTileByScreenPosition(this.LayerTileSize,PosX,PosY);
//			return _Grid[Pos.y][Pos.x];
//		}
		
//		override public function Render():void
//		{
//			graphics.clear();
//			var Col:int = 0;
//			var Row:int = 0;
//			var Tile:TileData = null;
//			if(_GridLineShow)
//			{
//				graphics.lineStyle(1,_GridLineColor);
//				graphics.beginFill(0xFFFFFF,0.6);	
//			}
//			
//			var PosX:uint = 0;
//			var PosY:uint = 0;
//			var PosH:uint = _GridSize >> 1;
//			for(Row = 0; Row < GridRow; Row++)
//			{
//				for(Col = 0; Col < GridColumn; Col++)
//				{
//					PosX = Col * (_GridSize * 2) + ((Row&1) * _GridSize);
//					PosY = Row * PosH;
//					graphics.moveTo(PosX - _GridSize,PosY);
//					graphics.lineTo(PosX,PosY - PosH);
//					graphics.lineTo(PosX + _GridSize,PosY);
//					graphics.lineTo(PosX,PosY + PosH);
//					graphics.lineTo(PosX - _GridSize,PosY);
//				}
//			}
//			
//			graphics.endFill();
//		}
	}
}