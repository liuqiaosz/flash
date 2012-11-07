package game.sdk.map.layer
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.sdk.assets.AssetLibraryManager;
	import game.sdk.assets.IAssetLibrary;
	import game.sdk.core.GameSprite;
	import game.sdk.core.IRender;
	import game.sdk.error.GameError;
	import game.sdk.map.tile.GenericTile;
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	import game.sdk.math.astar.AstarNode;
	
	import utility.ColorCode;
	import utility.ISerializable;

	public class GenericLayer extends GameSprite implements ILayer,ISerializable
	{
		protected var _GridRow:uint = 0;
		public function get GridRow():int
		{
			return _GridRow;
		}
		protected var _GridColumn:uint = 0;
		public function get GridColumn():int
		{
			return _GridColumn;
		}
//		protected var _GridSize:int = 0;
//		public function get LayerTileSize():int
//		{
//			return _GridSize;
//		}
		protected var _GridTileWidth:uint = 0;
		public function set GridTileWidth(Value:uint):void
		{
			_GridTileWidth = Value;
		}
		public function get GridTileWidth():uint
		{
			return _GridTileWidth;
		}
		
		protected var _GridTileHeight:uint = 0;
		public function set GridTileHeight(Value:uint):void
		{
			_GridTileHeight = Value;
		}
		public function get GridTileHeight():uint
		{
			return _GridTileHeight;
		}
		
		protected var _LayerWidth:int = 0;
		public function get LayerWidth():int
		{
			return _LayerWidth;
		}
		protected var _LayerHeight:int = 0;
		public function get LayerHeight():int
		{
			return _LayerHeight;
		}
		
//		//网格线是否显示
//		protected var _GridLineShow:Boolean = false;
//		public function set GridLineShow(Value:Boolean):void
//		{
//			_GridLineShow = Value;
//		}
//		public function get GridLineShow():Boolean
//		{
//			return _GridLineShow;
//		}
//	
//		//网格线颜色
//		protected var _GridLineColor:uint = ColorCode.BLACK;
//		public function set GridLineColor(Value:uint):void
//		{
//			_GridLineColor = Value;
//		}
//		public function get GridLineColor():uint
//		{
//			return _GridLineColor;
//		}
//		
//		protected var _GridLockFillColor:uint = ColorCode.WHITE;
//		public function set GridLockFillColor(Value:uint):void
//		{
//			_GridLockFillColor = Value;
//		}
//		public function get GridLockFillColor():uint
//		{
//			return _GridLockFillColor;
//		}
//		
//		protected var _GridLockFillEnable:Boolean = false;
//		public function set GridLockFillEnable(Value:Boolean):void
//		{
//			_GridLockFillEnable = Value;
//		}
//		public function get GirdLockFillEnable():Boolean
//		{
//			return _GridLockFillEnable;
//		}
		
		protected var _Mode:uint = LayerMode.LAYER_2D;
		public function set Mode(Value:uint):void
		{
			_Mode = Value;
		}
		protected var _Grid:Vector.<Vector.<TileData> > = null;
		
		protected var _Children:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		public function GenericLayer(Row:uint = 0,Column:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super();
			this._GridRow = Row;
			this._GridColumn = Column;
			this._GridTileWidth = TileWidth;
			this._GridTileHeight = TileHeight;
			_LayerWidth = Column * _GridTileWidth;
			_LayerHeight = Row * _GridTileHeight;
			Initializer();
		}
		
		/**
		 * 层数据更新
		 * 
		 * 
		 **/
		public function LayerUpdate(Row:int,Column:int,TileWidth:int,TileHeight:int):void
		{
			this._GridRow = Row;
			this._GridColumn = Column;
			this._GridTileWidth = TileWidth;
			this._GridTileHeight = TileHeight;
			_LayerWidth = Column * _GridTileWidth;
			_LayerHeight = Row * _GridTileHeight;
			Initializer();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(_Children.indexOf(child) < 0)
			{
				_Children.push(child);
			}
			
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(_Children.indexOf(child) < 0)
			{
				_Children.push(child);
			}
			return super.addChildAt(child,index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var Idx:int = _Children.indexOf(child);
			if(Idx >= 0)
			{
				_Children.splice(Idx,1);
			}
			if(contains(child))
			{
				return super.removeChild(child);
			}
			return child;
			
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = super.removeChildAt(index);
			var Idx:int = _Children.indexOf(child);
			if(Idx >= 0)
			{
				_Children.splice(Idx,1);
			}
			return child;
		}
		
		/**
		 * 获取指定范围的TileData的序列
		 **/
		protected function GetGridByPos(StartRow:uint,RowCount:uint,StartColumn:uint,ColumnCount:uint):Vector.<Vector.<TileData>>
		{
			var RowCount:uint = 0;
			if(StartRow + RowCount >= _Grid.length)
			{
				//重新定位开始行数
				StartRow = _Grid.length - RowCount;
			}
			
			if(StartColumn + ColumnCount >= _Grid[0].length)
			{
				//重新定位开始列数
				StartColumn = _Grid[0].length - ColumnCount;
			}
			
			var Result:Vector.<Vector.<TileData>> = new Vector.<Vector.<TileData>>(RowCount);
			
			for(var Row:uint = 0; Row < RowCount; Row++)
			{
				Result[Row] = new Vector.<TileData>(ColumnCount);
				for(var Col:uint = 0; Col < ColumnCount; Col++)
				{
					Result[Row][Col] = _Grid[StartRow + Row][StartColumn + Col];
				}
			}
			return Grid;	
		}
		
		public function get Grid():Vector.<Vector.<TileData>>
		{
			return _Grid;
		}
		
		protected var _GridQueue:Vector.<TileData> = null;
		public function get GridQueue():Vector.<TileData>
		{
			return _GridQueue;
		}
		/**
		 * 初始化网格数据
		 **/
		protected function Initializer():void
		{
			//初始化网格
			_Grid = new Vector.<Vector.<TileData>>(GridRow);
			_GridQueue = new Vector.<TileData>();
			for(var Row:uint = 0; Row < GridRow; Row++)
			{
				Grid[Row] = new Vector.<TileData>(GridColumn);
				for(var Col:uint = 0; Col < GridColumn; Col++)
				{
					var Tile:TileData = new TileData();
					Tile.Row = Row;
					Tile.Column = Col;
					Tile.Width = _GridTileWidth;
					Tile.Height = _GridTileHeight;
					_Grid[Row][Col] = Tile;
					_GridQueue.push(Tile);
				}
			}
			Update();
		}
		
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			//Data.writeByte(Mode);
			Data.writeShort(GridColumn);
			Data.writeShort(GridRow);
			//Data.writeShort(_GridSize);
			Data.writeShort(_GridTileWidth);
			Data.writeShort(_GridTileHeight);
			
			var ResByte:ByteArray = new ByteArray();
			var TileByte:ByteArray = null;
			var Res:String = "";
			for(var Row:int = 0; Row<GridRow; Row++)
			{
				for(var Col:int = 0; Col<GridColumn; Col++)
				{
					Data.writeByte(_Grid[Row][Col].State);
					Data.writeByte(_Grid[Row][Col].Mode);
					if(_Grid[Row][Col].Resource)
					{
						//Res += _Grid[Col][R].ResourceId + ":" + _Grid[Col][R].ResourceClass + " ";
						//ResByte.writeUTFBytes((Col * R) + ":" + _Grid[Col][R].ResourceId + ":" + _Grid[Col][R].ResourceClass + " ");
						ResByte.writeShort((Row * GridColumn + Col));
						Res = _Grid[Row][Col].ResourceId + ":" + _Grid[Row][Col].ResourceClass;
						ResByte.writeByte(Res.length);
						ResByte.writeUTFBytes(Res);
					}
				}
			}
			
			Data.writeBytes(ResByte,0,ResByte.length);
			return Data;
		}
		
		protected var _TileModeDiction:Dictionary = new Dictionary();
		
		public function Decode(Data:ByteArray):void
		{
			_TileModeDiction = new Dictionary();
			_GridColumn = Data.readShort();
			_GridRow = Data.readShort();
			//_GridSize = Data.readShort();
			_GridTileWidth = Data.readShort();
			_GridTileHeight = Data.readShort();
			_LayerWidth = GridColumn * _GridTileWidth;
			_LayerHeight = GridRow * _GridTileHeight;
			
			//_TileModeDiction[TileMode.TILE_BUILD] = new Vector.<TileData>();
			//_TileModeDiction[TileMode.TILE_NPC] = new Vector.<TileData>();
			//_TileModeDiction[TileMode.TILE_ROLECREATOR] = new Vector.<TileData>();
			//var WalkData:String = Data.readUTFBytes(GridColumn * GridRow);
			
			var Pos:Point = new Point();
			_GridQueue = new Vector.<TileData>(GridRow * GridColumn);
			var TileIdx:uint = 0;
			for(var Row:int = 0; Row<GridRow; Row++)
			{
				_Grid[Row] = new Vector.<TileData>(GridColumn);
				for(var Col:int = 0; Col<GridColumn; Col++)
				{
					var Tile:TileData = new TileData();
					Tile.Width = _GridTileWidth;
					Tile.Height = _GridTileHeight;
					Tile.State = Data.readByte();
					Tile.Mode = Data.readByte();
					Tile.Column = Col;
					Tile.Row = Row;
					_Grid[Row][Col] = Tile;
					//_GridQueue.push(Tile);
					_GridQueue[TileIdx] = Tile;
					TileIdx++;
					if(!(Tile.Mode in _TileModeDiction))
					//if(_TileModeDiction[Tile.Mode] ==null)
					{
						_TileModeDiction[Tile.Mode] = new Vector.<TileData>();
					}
					_TileModeDiction[Tile.Mode].push(Tile);
				}
			}
			
			while(Data.bytesAvailable > 0)
			{
				var Idx:uint = Data.readShort();
				var Len:int = Data.readByte();
				var Res:String = Data.readUTFBytes(Len);
				
				_GridQueue[Idx].ResourceId = Res.substring(0,Res.indexOf(":"));
				_GridQueue[Idx].ResourceClass = Res.substring(Res.indexOf(":") + 1);
			}
			Update();
		}
		
		public function FindGridNodeByPostion(PosX:uint,PosY:uint):TileData
		{
			var Col:int = PosX / this._GridTileWidth;
			var R:int = PosY / this._GridTileHeight;
			return this.Grid[Col][R];
		}
		
		public function FindGridTileByNode(GridNode:AstarNode):TileData
		{
			return Grid[GridNode.pr][GridNode.pc];
		}
		
		public function FindGridByStageMouse():GenericTile
		{
			var Local:Point = new Point(stage.mouseX,stage.mouseY);
			var Childs:Array = stage.getObjectsUnderPoint(Local);
			if(Childs.length > 0)
			{
				for(var Idx:int=0; Idx<Childs.length; Idx++)
				{
					if(Childs[Idx] is GenericTile)
					{
						return Childs[Idx];	
					}
				}
			}
			return null;
		}
		
		/**
		 * 移除所有子对象
		 **/
		public function RemoveAllChildren():void
		{
			if(_Children && _Children.length)
			{
				var Item:DisplayObject = null;
				for each(Item in _Children)
				{
					this.removeChild(Item);
				}
				_Children = new Vector.<DisplayObject>();
			}
		}
	}
}