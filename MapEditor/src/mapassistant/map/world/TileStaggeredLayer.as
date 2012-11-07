package mapassistant.map.world
{
	import flash.display.GraphicsPathCommand;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import game.sdk.map.CoordinateTools;
	import game.sdk.map.layer.StaggeredLayer;
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	
	import mapassistant.util.Common;
	
	import utility.ColorCode;

	public class TileStaggeredLayer extends AreaPartitionLayer
	{
		public function TileStaggeredLayer(Row:uint = 0,Column:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super(Row,Column,TileWidth,TileHeight);
		}
		
		
		override public function Render():void
		{
			graphics.clear();
			var Col:int = 0;
			var Row:int = 0;
			var Tile:TileData = null;
			graphics.lineStyle(1,0x000000);
			var PosX:uint = 0;
			var PosY:uint = 0;
			var PosH:uint = _GridTileHeight >> 1;
			var Grid:Vector.<Vector.<TileData>> = this.Grid;
			var GridRow:uint = Grid.length;
			var GridColumn:uint = Grid[0].length;
			
			this.graphics.beginFill(ColorCode.WHITE,0.3);
			this.graphics.drawRect(0,0,GridColumn * _GridTileWidth,GridRow * (_GridTileHeight >> 1));
			this.graphics.endFill();
			
			for(Row = 0; Row < GridRow; Row++)
			{
				for(Col = 0; Col < GridColumn; Col++)
				{
					PosX = Col * _GridTileWidth + ((Row&1) * _GridTileHeight);
					PosY = Row * PosH;
					if(	Grid[Row][Col].State == TileMode.TILE_STATE_FREE)
					{
						switch(Grid[Row][Col].Mode)
						{
							case TileMode.TILE_ROLECREATOR:
								graphics.beginFill(Common.COLOR_CREATOR);
								break;
							default:
								graphics.beginFill(Common.COLOR_WALK);
						}
//						if(Grid[Row][Col].Mode == TileMode.TILE_ROLECREATOR)
//						{
//							
//						}
						
					}
					
					this.graphics.moveTo(PosX - _GridTileHeight,PosY);
					this.graphics.lineTo(PosX,PosY - PosH);
					this.graphics.lineTo(PosX + _GridTileHeight,PosY);
					this.graphics.lineTo(PosX,PosY + PosH);
					this.graphics.lineTo(PosX - _GridTileHeight,PosY);
					if(	Grid[Row][Col].State == TileMode.TILE_STATE_FREE)
					{
						graphics.endFill();
					}
				}
			}
		}
		
		override public function FindGridNodeByPostion(PosX:uint, PosY:uint):TileData
		{
			var Pos:Point = this.globalToLocal(new Point(PosX,PosY));
			Pos = CoordinateTools.GetStaggeredTileByScreenPosition(_GridTileWidth,_GridTileHeight,Pos.x + _GridTileHeight,Pos.y + (_GridTileHeight >> 1));
			return Grid[Pos.y][Pos.x];
		}
		
		override public function AreaPartition(AreaWidth:uint,AreaHeight:uint):void
		{
			_AreaWidth = AreaWidth;
			_AreaHeight = AreaHeight;
			_AreaTileColumn = _AreaWidth / _GridTileWidth;
			_AreaTileRow = _AreaHeight / (_GridTileHeight >> 1);
			_AreaColumn = _LayerWidth / _AreaWidth;
			_AreaRow = _LayerHeight / _AreaHeight;
			_HasPartition = true;
			//默认当前视图是第一区块
			SetArea(0,0);
		}
	}
}