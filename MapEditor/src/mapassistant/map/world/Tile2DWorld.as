package mapassistant.map.world
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.dns.AAAARecord;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.map.layer.IsoLayer;
	import game.sdk.map.layer.LayerMode;
	import game.sdk.map.tile.GenericTile;
	import game.sdk.map.tile.TileData;
	
	import mapassistant.data.table.TableSymbol;
	import mapassistant.event.EventConstant;
	import mapassistant.event.NotifyEvent;
	import mapassistant.resource.ResourceItem;
	import mapassistant.symbol.GenericSymbol;
	import mapassistant.ui.SymbolGridShowcase;
	import mapassistant.ui.SymbolTile;
	import mapassistant.util.SymbolMode;
	
	/**
	 * 
	 * 
	 * 三层
	 * 
	 * 1: 网格层
	 * 2: 地图层
	 * 3: 物件层
	 * 
	 **/
	public class Tile2DWorld extends World implements IWorld
	{
//		protected var GridRow:int = 0;
//		protected var GridColumn:int = 0;
		protected var GridSize:int = 0;
		//protected var Mode:int = 0;
		
		protected var LayerState:int = 0;
		
		//protected var GridState:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
		public function Tile2DWorld(Row:int,Column:int,Size:int)
		{
			super(Row,Column,Size,Size);
			this.Mode = WorldMode.TILE_2D;
			this.LayerState = LayerMode.LAYER_2D;
			
			GridSize = Size;
//			switch(Mode)
//			{
//				case WorldMode.TILE_2D:
//					LayerState = LayerMode.LAYER_2D;
//					break;
//				case WorldMode.TILE_3D_DIAMOND:
//					LayerState = LayerMode.LAYER_3D_DIAMOND;
//					break;
//				case WorldMode.TILE_3D_STAGGERED:
//					LayerState = LayerMode.LAYER_3D_STAGGERED;
//					break;
//			}
			CreateOperateLayer();
			CreateDataGrid(_WorldRow,_WorldColumn,Size);
			//CreateItemLayer(GridColumn,GridRow,Size);
			//_ItemLayer.GridLineShow = true;
			//_DataGridLayer.GridLineSwitch();
			//_ItemLayer.GridLineSwitch();
		}
		
		
		
		public function Dispose():void
		{
		}
		
		public function WorldToXML():String
		{
			return "";
		}
		
		public function WorldToMapFile():ByteArray
		{
			return null;
		}
		
//		//分隔状态
//		private var _Split:Boolean = false;
//		public function get Split():Boolean
//		{
//			return _Split;
//		}
//		private var _BlockWidth:int = 0;
//		public function get BlockWidth():int
//		{
//			return _BlockWidth;
//		}
//		private var _BlockHeight:int = 0;
//		public function get BlockHeight():int
//		{
//			return _BlockHeight;
//		}
//		private var _BlockColumn:int = 0;
//		private var _BlockRow:int = 0;
//		
//		/**
//		 * 地图分割
//		 **/
//		public function WorldSplit(BlockWidth:int,BlockHeight:int):void
//		{
//			_BlockWidth = BlockWidth;
//			_BlockHeight = BlockHeight;
//			
//			//计算子场景切割后的行数,列数
//			_BlockRow = _WorldHeight / _BlockHeight;
//			_BlockColumn = _WorldWidth / _BlockWidth;
//			_Split = true;
//			this._DataGridLayer.AreaPartition(BlockWidth,BlockHeight);
//			if(_TerrainLayer)
//			{
//				this._TerrainLayer.AreaPartition(BlockWidth,BlockHeight);
//			}
//			if(_ItemLayer)
//			{
//				this._ItemLayer.AreaPartition(BlockWidth,BlockHeight);
//			}
//		}
//		
//		private var _AtBlockColumn:int = 0;
//		private var _AtBlockRow:int = 0;
//		public function SetBlock(BlockColumn:int,BlockRow:int):void
//		{
//			_AtBlockColumn = BlockColumn;
//			_AtBlockRow = BlockRow;
//			this._DataGridLayer.SetArea(BlockColumn,BlockRow);
//			if(_TerrainLayer)
//			{
//				this._TerrainLayer.SetArea(BlockColumn,BlockRow);
//			}
//			if(_ItemLayer)
//			{
//				this._ItemLayer.SetArea(BlockColumn,BlockRow);
//			}
//		}
		
		public function FindWorldScene(Column:int,Row:int):Vector.<Vector.<TileData>>
		{
			return null;
		}
		
		
		
		public function UpdateSymbolSprite(Symbol:GenericSymbol,Resource:ResourceItem):void
		{
		}
		
		//地表层
		//protected var _TerrainLayer:TileLayer = null;
		public function get TerrainLayer():GenericLayer
		{
			return _TerrainLayer;
		}
		
		
		/**
		 * 创建地表层
		 **/
		public function CreateTerrain(Row:uint,Column:uint,TileWidth:uint,TileHeight:uint):void
		{
			if(_TerrainLayer != null && this.contains(_TerrainLayer))
			{
				this.removeChild(_TerrainLayer);
				_TerrainLayer = null;
			}
			_TerrainLayer = new TileLayer(Row,Column,TileWidth);
			if(_DataGridLayer.HasPartition)
			{
				
				this._TerrainLayer.AreaPartition(_DataGridLayer.AreaWidth,_DataGridLayer.AreaHeight);
				this._TerrainLayer.SetArea(_DataGridLayer.AreaColumn,_DataGridLayer.AreaRow);
			}
			UpdateDeep();
			//width = _TerrainLayer.width;
			//height = _TerrainLayer.height;
			//_TerrainLayer.CloseInvalidateMode();
			_TerrainLayer.GridShow();
			_TerrainLayer.alpha = 0.6;
			//return _TerrainLayer;
		}
		
		//数据层
		//protected var _DataGridLayer:TileLayer = null;
		public function get DataGridLayer():GenericLayer
		{
			return _DataGridLayer;
		}
		
		/**
		 * 创建网格数据层
		 **/
		public function CreateDataGrid(Row:int,Column:int,TileSize:int):void
		{
			_DataGridLayer = new TileLayer(Row,Column,TileSize);
			UpdateDeep();
			//return _DataGridLayer;
		}
		
		//protected var _OperateLayer:TileLayer = null;
		protected function CreateOperateLayer():void
		{
			_OperateLayer = new TileLayer(_WorldRow,_WorldColumn,GridSize);
			UpdateDeep();
		}
		
		
		
		//protected var _ItemLayer:TileLayer = null;
		public function CreateItemLayer(Column:int,Row:int,TileSize:int):TileLayer
		{
			if(_ItemLayer != null && this.contains(_ItemLayer))
			{
				this.removeChild(_ItemLayer);
				_ItemLayer = null;
			}
			_ItemLayer = new TileLayer(Row,Column,TileSize);
			UpdateDeep();
			//width = _TerrainLayer.width;
			//height = _TerrainLayer.height;
			return _ItemLayer as TileLayer;
		}
		
		public function get ItemLayer():GenericLayer
		{
			return _ItemLayer;
		}
		
		
		
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			Data.writeByte(WorldMode.TILE_2D);
			Data.writeUTFBytes(_WorldName);
			Data.writeByte(32);
			Data.writeShort(this._WorldColumn);
			Data.writeShort(this._WorldRow);
			Data.writeShort(GridSize);
			
			if(_DataGridLayer.HasPartition)
			{
				Data.writeByte(1);
				Data.writeShort(_DataGridLayer.AreaWidth);
				Data.writeShort(_DataGridLayer.AreaHeight);
			}
			else
			{
				Data.writeByte(0);
			}
			var LayerData:ByteArray = null;
			
			LayerData = _DataGridLayer.Encode();
			Data.writeInt(LayerData.length);
			Data.writeBytes(LayerData,0,LayerData.length);
			
			LayerData = _TerrainLayer.Encode();
			Data.writeInt(LayerData.length);
			Data.writeBytes(LayerData,0,LayerData.length);
//			LayerData = _ItemLayer.Encode();
//			Data.writeInt(LayerData.length);
//			Data.writeBytes(LayerData,0,LayerData.length);
			return Data;
		}
		
		public function Decode(Data:ByteArray):void
		{
			var NameData:ByteArray = new ByteArray();
			var Value:uint = 0;
			while(1)
			{
				Value = Data.readByte();
				if(Value == 32)
				{
					NameData.position = 0;
					_WorldName = NameData.readUTFBytes(NameData.length);
					NameData.clear();
					NameData = null;
					break;
				}
				NameData.writeByte(Value);
			}
			Mode = Data.readByte();
			_WorldColumn = Data.readShort();
			_WorldRow = Data.readShort();
			GridSize = Data.readShort();
			
			_WorldHeight = _WorldRow * GridSize;
			_WorldWidth = _WorldColumn * GridSize;
			
			var Partition:Boolean = Boolean(Data.readByte());
			var AreaWidth:uint = 0;
			var AreaHeight:uint = 0;
			if(Partition)
			{
				AreaWidth = Data.readShort();
				AreaHeight = Data.readShort();
			}
			
			var Len:int = Data.readInt();
			var LayerData:ByteArray = new ByteArray();
			Data.readBytes(LayerData,0,Len);
			
			_DataGridLayer.Decode(LayerData);
			_DataGridLayer.GridShow();
			Len = Data.readInt();
			
			this.CreateTerrain(0,0,0,0);
			LayerData = new ByteArray();
			Data.readBytes(LayerData,0,Len);
			_TerrainLayer.Decode(LayerData);
			_TerrainLayer.GridShow();
			_TerrainLayer.Update();
			if(Partition)
			{
				_DataGridLayer.AreaPartition(AreaWidth,AreaHeight);
				_TerrainLayer.AreaPartition(AreaWidth,AreaHeight);
				//this.AreaPartition(_AreaWidth,_AreaHeight);
				//this.WorldSplit(_BlockWidth,_BlockHeight);
			}
		}
	}
}
