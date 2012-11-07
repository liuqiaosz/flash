package mapassistant.map.world
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import game.sdk.map.layer.IsoLayer;
	import game.sdk.map.tile.GenericTile;
	
	import mapassistant.data.table.TableSymbol;
	import mapassistant.event.EventConstant;
	import mapassistant.event.NotifyEvent;
	import mapassistant.resource.ResourceItem;
	import mapassistant.symbol.BitmapSymbol3D;
	import mapassistant.symbol.GenericSymbol;
	import mapassistant.ui.SymbolGridShowcase;
	import mapassistant.ui.SymbolTile;
	import mapassistant.util.SymbolMode;
	
	public class IsometricWorld
	{
		
		//操作层(鼠标焦点显示,物件拖动显示,物件幽灵显示)
		private var OperationLayer:IsoLayer = null;
		//网格层
		private var GridLayer:IsoLayer = null;
		//地图层
		private var TerrainLayer:IsoLayer = null;
		//焦点高亮对象
		//private var MouseFocusTile:GridTile = null;
		//元件
		private var Symbol:SymbolTile = null;
		
		//网格
		private var TileGrids:Vector.<Vector.<GenericTile>> = null;
		
		//当前地图已经使用的元件
		private var UsedSymbol:Dictionary = new Dictionary();
		
//		override public function Dispose():void
//		{
//			removeEventListener(MouseEvent.MOUSE_MOVE,OnMouseMove);
//			OperationLayer = null;
//			GridLayer = null;
//			TerrainLayer = null;
//			//MouseFocusTile = null;
//		}
//		
//		public function IsometricWorld(Row:int,Column:int,Size:int)
//		{
//			super(Row,Column,Size,WorldMode.TILE_3D_DIAMOND);
//
//			InitializeGridLayer();
//			InitializeTerrainLayer();
//			InitializeItemLayer();
//			InitializeOperationLayer();
//			
//			addEventListener(MouseEvent.MOUSE_MOVE,OnMouseMove);
//		}
//		
//		/**
//		 * 更新元件信息
//		 * 
//		 **/
//		override public function UpdateSymbolSprite(SymbolData:GenericSymbol,Resource:ResourceItem):void
//		{
//			//MouseFocusTile.visible = false;
//			if(!Symbol)
//			{
//				Symbol = new SymbolTile(SymbolData,Resource);
//				//Symbol.mouseEnabled = false;
//				//Symbol.Resource = new Bitmap(new Resource.Source() as BitmapData);
//				OperationLayer.addChild(Symbol);
//				addEventListener(MouseEvent.CLICK,AddSymbol);
//			}
//			//Symbol.UpdateShowcase(SymbolData.BlockRow,SymbolData.BlockColumn,SymbolData.TileSize,0);
//			//Symbol.UpdateResourceOffset(SymbolData.OffsetX,SymbolData.OffsetY);
//		}
//		
//		protected function AddSymbol(event:MouseEvent):void
//		{
//			if(CurrentFocus)
//			{
//				var Symbol3D:BitmapSymbol3D = Symbol.Symbol as BitmapSymbol3D;
//				var TileGroup:Array = GridLayer.FindGridGroup(CurrentFocus,Symbol3D.SymbolRow,Symbol3D.SymbolColumn);
//				var Idx:int = 0;
//				//校验是否有网格已经是被占用装填
//				for(Idx=0; Idx<TileGroup.length; Idx++)
//				{
//					if(GenericTile(TileGroup[Idx]).Locked)
//					{
//						trace("已占用");
//						return;
//					}
//				}
//				
//				for(Idx=0; Idx<TileGroup.length; Idx++)
//				{
//					GenericTile(TileGroup[Idx]).Color = 0x0000FF;
//					GenericTile(TileGroup[Idx]).Update();
//					GenericTile(TileGroup[Idx]).TileLocked();
//				}
//				
//				//锁定
//				CurrentFocus.Color = 0xFF0000;
//				CurrentFocus.Update();
//				//保存元件数据
//				//CurrentFocus.Symbol = Symbol.SymbolData;
//				
//				//元件记录锚点占用的TILE
//				Symbol.Tile = CurrentFocus;
//				
////				if(!UsedSymbol.hasOwnProperty(Symbol.SymbolData.Name))
////				{
////					UsedSymbol[Symbol.SymbolData.Name] = Symbol.SymbolData.Clone();
////				}
////				if(Symbol.SymbolData.SymbolType == SymbolMode.TERRAIN)
////				{
////					//地表物件放入地表层
////					TerrainLayer.addChild(Symbol);
////				}
////				else
////				{
////					ItemLayer.addChild(Symbol);
////					ItemLayer.UpdateChildrenDepth();
////				}
////				Symbol = null;
////				CurrentFocus = null;
////				removeEventListener(MouseEvent.CLICK,AddSymbol);
//			}
//		}
//		
//		private var LocalPoint:Point = new Point();
//		private var CurrentFocus:GenericTile = null;
//		/**
//		 * 
//		 * 鼠标移动
//		 * 
//		 **/
//		protected function OnMouseMove(event:MouseEvent):void
//		{
//			CurrentFocus = GridLayer.FindGridByStageMouse();
//			if(CurrentFocus)
//			{
//				if(Symbol)
//				{
//					Symbol.Pos3D = CurrentFocus.Pos3D;
//				}
//			}
//		}
//		
//		/**
//		 * 
//		 * 初始化操作层
//		 * 
//		 **/
//		private function InitializeOperationLayer():void
//		{
//			OperationLayer = new IsoLayer(GridRow,GridColumn,GridSize);
//			OperationLayer.x = width >> 1;
//			OperationLayer.y = height >> 1;
//			addChild(OperationLayer);
//			//			MouseFocusTile = new GridTile(GridSize);
//			//			MouseFocusTile.visible = false;
//			//			MouseFocusTile.BorderColor = 0xFF0000;
//			//			MouseFocusTile.Color = 0x5D5D5D;
//			//			MouseFocusTile.Initialize();
//			//			OperationLayer.addChild(MouseFocusTile);
//		}
//		
//		/**
//		 * 
//		 * 初始化地形层
//		 * 
//		 **/
//		private function InitializeTerrainLayer():void
//		{
//			TerrainLayer = new IsoLayer(GridRow,GridColumn,GridSize);
//			TerrainLayer.x = width >> 1;
//			TerrainLayer.y = height >> 1;
//			addChild(TerrainLayer);
//		}
//		
//		/**
//		 * 
//		 * 初始化物件层
//		 * 
//		 **/
//		private function InitializeItemLayer():void
//		{
////			ItemLayer = new IsoLayer(GridRow,GridColumn,GridSize);
////			ItemLayer.x = width >> 1;
////			ItemLayer.y = height >> 1;
////			addChild(ItemLayer);
//		}
//		
//		/**
//		 * 
//		 * 初始化网格层
//		 * 
//		 **/
//		private function InitializeGridLayer():void
//		{
//			//初始化只构建网格层
//			GridLayer = new IsoLayer(GridRow,GridColumn,GridSize);
//			TileGrids = GridLayer.InitializeGridTile();
//			//			//创建网格对象
//			//			for(var RowIndex:int=0; RowIndex<GridRow; RowIndex++)
//			//			{
//			//				for(var ColIndex:int=0; ColIndex<GridColumn; ColIndex++)
//			//				{
//			//					var Tile:GridTile = new GridTile(GridSize,RowIndex * GridSize,0,ColIndex * GridSize);
//			//					Tile.Initialize();
//			//					GridLayer.addChild(Tile);
//			//				}
//			//			}
//			addChild(GridLayer);
//			GridLayer.x = width >> 1;
//			GridLayer.y = height >> 1;	
//		}
//		
//		/**
//		 * 
//		 * 转换成XML数据
//		 * 
//		 **/
//		override public function WorldToXML():String
//		{
//			var WorldData:String = "<World Row=\"" + GridRow + "\" Column=\"" + GridColumn + "\" TileSie=\"" + GridSize + "\">";
////			//输出网格数据
////			var Idx:*;
////			var Tile:SymbolTile = null;
////			var GridData:String = "";
////			//基础网格数据
////			var Children:Array = GridLayer.Childrens;
////			for(Idx in Children)
////			{
////				GridData += (GenericTile(Children[Idx]).Locked ? "1":"0");
////			}
////			GridData = "<Grid>" + GridData + "</Grid>";
////			WorldData += GridData;
////			var SymbolXML:String = "";
////			var Symbol:BitmapSymbol3D = null;
////			//元件数据
////			for(Idx in UsedSymbol)
////			{
////				Symbol = UsedSymbol[Idx];
////				SymbolXML += "<Symbol Name=\"" + Symbol.Class + "\" BlockRow=\"" + Symbol.BlockRow + "\" BlockColumn=\"" + Symbol.BlockColumn + "\" OffsetX=\"" +
////					Symbol.OffsetX + "\" OffsetY=\"" + Symbol.OffsetY + "\" Resource=\"" + Symbol.ResourceName + "\" Class=\"" + Symbol.ResourceClass + "\" BlockHeight=\"" +
////					Symbol.TileHeight + "\" Type=\"" + Symbol.Type + "\" />";
////			}
////			SymbolXML = "<Symbols>" + SymbolXML + "</Symbols>";
////			WorldData += SymbolXML;
////			var TerrainXML:String = "<Terrains>";
////			//地表物件数据
////			Children = TerrainLayer.Childrens;
////			for(Idx in Children)
////			{
////				Tile = SymbolTile(Children[Idx]);
////				TerrainXML += "<Item Row=\"" + Tile.Tile.TileRow + "\" Column=\"" + Tile.Tile.TileColumn + "\" Symbol=\"" + Symbol. .Name + "\" />";
////			}
////			TerrainXML += "</Terrains>";
////			WorldData += TerrainXML;
////			//物件层
////			Children = ItemLayer.Childrens;
////			var SpriteXML:String = "<Sprites>";
////			for(Idx in Children)
////			{
////				Tile = SymbolTile(Children[Idx]);
////				SpriteXML += "<Item Row=\"" + Tile.Tile.TileRow + "\" Column=\"" + Tile.Tile.TileColumn + "\" Symbol=\"" + Tile.SymbolData.Name + "\" />";
////			}
////			SpriteXML += "</Sprites>";
////			WorldData += SpriteXML;
////			WorldData += "</World>";
//			return WorldData;
//		}
	}
}