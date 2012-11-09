package mapassistant.map.world
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.map.layer.LayerMode;
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	
	import mapassistant.assetblock.AssetBlockSelectGroup;
	import mapassistant.resource.Resource;
	import mapassistant.resource.ResourceManager;
	import mapassistant.symbol.SymbolFactory;
	
	import utility.ColorCode;
	
	/**
	 * Tile层定义
	 **/
	public class TileLayer extends AreaPartitionLayer
	{
		//可通行TILE渲染颜色
		protected var _WalkTileFillColor:uint = ColorCode.GREEN;
		
		//角色创建TILE渲染颜色
		protected var _RoleCreatorTileFillColor:uint = ColorCode.BLACK;
		
		//建筑TILE渲染颜色
		protected var _BuildTileFillColor:uint = ColorCode.BLUE;
		
		//NPC TILE渲染颜色
		protected var _NpcTileFillColor:uint = ColorCode.AQUA; 
		
		public function TileLayer(Row:int = 0,Column:int = 0,TileWidth:int = 0,TileHeight:int = 0)
		{
			super(Row,Column,TileWidth,TileHeight);
			//addEventListener(MouseEvent.MOUSE_MOVE,OnMove);
		}
		
		private var Focus:Shape = null;
		private var Pos:Point = new Point();
		private function OnMove(event:MouseEvent):void
		{
			Pos.x = event.stageX;
			Pos.y = event.stageY;
			Pos = globalToLocal(Pos);
			
			Pos.x = int((Pos.x / _GridTileWidth)) * _GridTileWidth;
			Pos.y = int((Pos.y / _GridTileHeight)) * _GridTileHeight;
			if(Focus == null)
			{
				Focus = new Shape();
				Focus.graphics.beginFill(0xEEFFEE);
				Focus.graphics.drawRect(0,0,_GridTileWidth,_GridTileHeight);
				addChild(Focus);
			}
			Focus.x = Pos.x;
			Focus.y = Pos.y;
		}
		
//		public function ChangeTileMode(Row:uint,Column:uint,Mode:uint):TileData
//		{
//			var Tile:TileData = Grid[Row][Column];
//			
//			if(Tile)
//			{
//				Tile.Mode = Mode;
//				DrawTile(Tile);
//			}
//			
//			return Tile;
//		}
		
//		public function ChangeTileState(Row:uint,Column:uint,State:uint):TileData
//		{
//			var Tile:TileData = Grid[Row][Column];
//			
//			if(Tile)
//			{
//				Tile.State = State;
//				DrawTile(Tile);
//			}
//			return Tile;
//		}
//		
//		protected function DrawTile(Tile:TileData):void
//		{
//			if(Tile.ResourceId != "" && Tile.Resource == null)
//			{
//				var Res:Resource = ResourceManager.Instance.FindResourceBySimpleName(Tile.ResourceId);
//				if(Res)
//				{
//					Tile.Resource = Bitmap(Res.FindSourceByClass(Tile.ResourceClass).Source).bitmapData;
//				}
//				
//			}
//			if(Tile.Resource)
//			{
//				graphics.beginBitmapFill(Tile.Resource);
//				graphics.drawRect(Tile.BlockColumn * _GridTileWidth,Tile.BlockRow * _GridTileHeight,_GridTileWidth,_GridTileHeight);
//				graphics.endFill();
//				return;
//			}
//			switch(Tile.Mode)
//			{
//				case TileMode.TILE_EMPTY:
//					if(Tile.State == TileMode.TILE_STATE_FREE)
//					{
//						graphics.moveTo(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight);
//						graphics.beginFill(_WalkTileFillColor);
//						graphics.drawRect(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight,_GridTileWidth,_GridTileHeight);
//						graphics.endFill();
//					}
//					break;
//				case TileMode.TILE_BUILD:
//					graphics.moveTo(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight);
//					graphics.beginFill(_BuildTileFillColor);
//					graphics.drawRect(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight,_GridTileWidth,_GridTileHeight);
//					graphics.endFill();
//					break;
//				case TileMode.TILE_ROLECREATOR:
//					graphics.moveTo(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight);
//					graphics.beginFill(_RoleCreatorTileFillColor);
//					graphics.drawRect(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight,_GridTileWidth,_GridTileHeight);
//					graphics.endFill();
//					break;
//				case TileMode.TILE_NPC:
//					graphics.moveTo(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight);
//					graphics.beginFill(_NpcTileFillColor);
//					graphics.drawRect(Tile.BlockColumn * this._GridTileWidth,Tile.BlockRow * _GridTileHeight,_GridTileWidth,_GridTileHeight);
//					graphics.endFill();
//					break;
//			}
//		}
		
		//protected var _CachePos:Point = new Point();
		override protected function OnMouseMove(event:MouseEvent):void
		{
			Pos.x = event.stageX;
			Pos.y = event.stageY;
			Pos = globalToLocal(Pos);
			
			Pos.x = int((Pos.x / _GridTileWidth)) * _GridTileWidth;
			Pos.y = int((Pos.y / _GridTileHeight)) * _GridTileHeight;
			if(Focus == null)
			{
				Focus = new Shape();
				Focus.graphics.beginFill(0xEEFFEE);
				Focus.graphics.drawRect(0,0,_GridTileWidth,_GridTileHeight);
				addChild(Focus);
			}
			Focus.x = Pos.x;
			Focus.y = Pos.y;
			
			if(_AssetBlockGroup && _CacheBitmap)
			{
				Focus.graphics.clear();
				Focus.alpha = 0.5;
				Focus.graphics.beginBitmapFill(_CacheBitmap);
				Focus.graphics.drawRect(0,0,_CacheBitmap.width,_CacheBitmap.height);
				Focus.graphics.endFill();
				//_CachePos.x = event.localX / this._GridTileWidth;
				//_CachePos.y = event.localY / this._GridTileHeight;
				//Update();
			}
		}
		
		
		private var Draw:Graphics = null;
		override public function Render():void
		{
			Draw = graphics;
			Draw.clear();
			Draw.beginFill(0xFFFFFF,0.1);
			Draw.drawRect(0,0,this.LayerWidth,this.LayerHeight);
			Draw.endFill();
			
//			if(_CacheBitmap)
//			{
//				
//				Draw.beginBitmapFill(_CacheBitmap);
//				Draw.drawRect(_CachePos.x,_CachePos.y,_CacheBitmap.width,_CacheBitmap.height);
//				Draw.endFill();
//			}
		}
		
//		override public function Render():void
//		{
//			graphics.clear();
//			_GridShow = true;
//			if(_GridShow)
//			{
//				var Grid:Vector.<Vector.<TileData>> = this.Grid;
//				var Row:uint = 0;
//				var Col:uint = 0;
//				var GridRow:uint = Grid.length;
//				var GridColumn:uint = Grid[0].length;
//				var Width:uint = GridColumn * this._GridTileWidth;
//				var Height:uint = GridRow * this._GridTileHeight;
//				graphics.beginFill(_GridFillColor,_GridFillAlpha);
//				graphics.drawRect(0,0,Width,Height);
//				graphics.endFill();
//				
//				graphics.lineStyle(_GridThinkness,_GridLineColor,_GridLineAlpha);
//				
//				for(Row = 0; Row<GridRow; Row++)
//				{
//					graphics.moveTo(0,Row * _GridTileHeight);
//					graphics.lineTo(Width,Row * _GridTileHeight);
//				}
//				
//				for(Col = 0; Col < GridColumn; Col++)
//				{
//					graphics.moveTo(Col * _GridTileHeight,0);
//					graphics.lineTo(Col * _GridTileHeight,Height);
//				}
//				
//				for(Row = 0; Row<GridRow; Row++)
//				{
//					//graphics.moveTo(0,Row * _GridSize);
//					//graphics.lineTo(Width,Row * _GridSize);
//					for(Col = 0; Col < GridColumn; Col++)
//					{
//						//graphics.moveTo(Col * _GridSize,0);
//						//graphics.lineTo(Col * _GridSize,Height);
//						DrawTile(Grid[Row][Col]);
//					}
//				}
//			}
//		}
	}
}