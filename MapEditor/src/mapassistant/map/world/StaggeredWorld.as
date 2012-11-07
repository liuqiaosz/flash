package mapassistant.map.world
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import game.sdk.map.CoordinateTools;
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	
	import mapassistant.resource.Resource;
	import mapassistant.resource.ResourceItem;
	import mapassistant.resource.ResourceManager;
	import mapassistant.symbol.GenericSymbol;
	import mapassistant.util.Common;
	
	import mx.controls.Alert;
	
	import utility.ColorCode;
	import utility.Tools;

	public class StaggeredWorld extends World implements IWorld
	{
		//路点编辑焦点框颜色
		public function StaggeredWorld(WorldRow:uint = 0,WorldColumn:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super(WorldRow,WorldColumn,TileWidth,TileHeight);
			_WorldHeight = _WorldHeight >> 1;
			_OperateLayer = new AreaPartitionLayer();
			addChild(_OperateLayer);
			CreateDataGridLayer();
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,MoveOnWorld);
		}
		
		/**
		 * 编辑场景鼠标移动处理
		 **/
		protected function MoveOnWorld(event:MouseEvent):void
		{
			this.graphics.clear();
			var Pos:Point = null;
			var Tile:TileData = null;
			var H:uint = 0;
			var X:uint = 0
			var Y:uint = 0;
			switch(_EditMode)
			{
				case EDIT_WALK:	//路点编辑模式
					//Pos = _DataGridLayer.globalToLocal(new Point(event.stageX,event.stageY));
					Tile = _DataGridLayer.FindGridNodeByPostion(event.stageX,event.stageY);
					H = _DataGridLayer.GridTileHeight >> 1;
					X = Tile.BlockColumn * _DataGridLayer.GridTileWidth + ((Tile.BlockRow&1) * _DataGridLayer.GridTileHeight);
					Y = Tile.BlockRow * H;
					graphics.beginFill(Common.COLOR_WALK);
					graphics.moveTo(X - _DataGridLayer.GridTileHeight,Y);
					graphics.lineTo(X,Y - H);
					graphics.lineTo(X + _DataGridLayer.GridTileHeight,Y);
					graphics.lineTo(X,Y + H);
					graphics.lineTo(X - _DataGridLayer.GridTileHeight,Y);
					graphics.endFill();
					
					if(this._MoveWalkActived && Tile.State == TileMode.TILE_STATE_LOCK)
					{
						Tile.State = TileMode.TILE_STATE_FREE;
						_DataGridLayer.Update();
					}
					break;
				case EDIT_CREATOR:
					Tile = _DataGridLayer.FindGridNodeByPostion(event.stageX,event.stageY);
					
					H = _DataGridLayer.GridTileHeight >> 1;
					X = Tile.BlockColumn * _DataGridLayer.GridTileWidth + ((Tile.BlockRow&1) * _DataGridLayer.GridTileHeight);
					Y = Tile.BlockRow * H;
					graphics.beginFill(Common.COLOR_CREATOR);
					graphics.moveTo(X - _DataGridLayer.GridTileHeight,Y);
					graphics.lineTo(X,Y - H);
					graphics.lineTo(X + _DataGridLayer.GridTileHeight,Y);
					graphics.lineTo(X,Y + H);
					graphics.lineTo(X - _DataGridLayer.GridTileHeight,Y);
					graphics.endFill();
					break;
				case EDIT_SYMBOL:
					Tile = _DataGridLayer.FindGridNodeByPostion(event.stageX,event.stageY);
					X = Tile.BlockColumn * _DataGridLayer.GridTileWidth + ((Tile.BlockRow&1) * _DataGridLayer.GridTileHeight);
					Y = Tile.BlockRow * H;
					
					if(_Symbol)
					{
						var Res:ResourceItem = null;
						if(_Symbol.LinkType == GenericSymbol.LINK_SWF)
						{
							var Lib:Resource = ResourceManager.Instance.FindResourceBySimpleName(_Symbol.Swf);
							Res = Lib.FindSourceByClass(_Symbol.Class);
						}
						
						graphics.beginBitmapFill(Bitmap(Res.Source).bitmapData);
						graphics.drawRect(X - _Symbol.OffsetX,Y - _Symbol.OffsetY,Bitmap(Res.Source).width,Bitmap(Res.Source).height);
						graphics.endFill();
					}
					break;
			}
		}
		
		protected var _Creator:TileData = null;
		/**
		 * 设置ROLE创建点
		 **/
		protected function AddRoleCreator(event:MouseEvent):void
		{
			var Tile:TileData = _DataGridLayer.FindGridNodeByPostion(event.stageX,event.stageY);
			
			if(_Creator)
			{
				_Creator.Mode = TileMode.TILE_EMPTY;
			}
			
			_Creator = Tile;
			_Creator.Mode = TileMode.TILE_ROLECREATOR;
			_Creator.State = TileMode.TILE_STATE_FREE;
			_DataGridLayer.Update();
		}
		
		override public function EnableRoleCreatorEdit():void
		{
			super.EnableRoleCreatorEdit();
			addEventListener(MouseEvent.CLICK,AddRoleCreator);
		}
		
		/**
		 * 创建数据层
		 **/
		protected function CreateDataGridLayer():void
		{
			_DataGridLayer = new TileStaggeredLayer(_WorldRow,_WorldColumn,_TileWidth,_TileHeight);
			//addChild(_DataGridLayer);
			this.UpdateDeep();
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
			//addChild(_TerrainLayer);
			UpdateDeep();
			//UpdateDeep();
			//width = _TerrainLayer.width;
			//height = _TerrainLayer.height;
			//_TerrainLayer.CloseInvalidateMode();
			_TerrainLayer.GridShow();
			_TerrainLayer.alpha = 0.6;
			//return _TerrainLayer;
		}
		
		/**
		 * 从数据层获取指定坐标位置的TILE
		 **/
//		override public function FindTileFromDataGridByScreenPos(PosX:uint, PosY:uint):TileData
//		{
//			var Pos:Point = CoordinateTools.GetStaggeredTileByScreenPosition(_TileWidth,_TileHeight,PosX,PosY);
//			
//			return _DataGridLayer.Grid[Pos.y][Pos.x];
//		}
		
		public function get DataGridLayer():GenericLayer
		{
			return _DataGridLayer;
		}
		public function get TerrainLayer():GenericLayer
		{
			return _TerrainLayer;
		}
		
		public function WorldToXML():String
		{
			return "";
		}
		
		public function UpdateSymbolSprite(Symbol:GenericSymbol,Resource:ResourceItem):void
		{
			
		}
		
		override public function ResetEditMode():void
		{
			switch(_EditMode)
			{
				case TileMode.TILE_ROLECREATOR:
					this.removeEventListener(MouseEvent.CLICK,AddRoleCreator);
					break;
			}
			super.ResetEditMode();
		}
		
		public function Encode():ByteArray
		{
			var Header:ByteArray = new ByteArray();
			Header.writeByte(WorldMode.TILE_3D_STAGGERED);
			Header.writeUTFBytes(_WorldName);
			Header.writeByte(Common.BYTE_CHAR_END);
			Header.writeShort(this._WorldColumn);
			Header.writeShort(this._WorldRow);
			
			if(_DataGridLayer.HasPartition)
			{
				Header.writeByte(Common.AREAPARTITION_YES);
				Header.writeShort(_DataGridLayer.AreaWidth);
				Header.writeShort(_DataGridLayer.AreaHeight);
			}
			else
			{
				Header.writeByte(Common.AREAPARTITION_NO);
			}
			
			var Body:ByteArray = new ByteArray();
			var LayerData:ByteArray = null;
			
			LayerData = _DataGridLayer.Encode();
			Body.writeInt(LayerData.length);
			Body.writeBytes(LayerData,0,LayerData.length);
			
			LayerData = _TerrainLayer.Encode();
			Body.writeInt(LayerData.length);
			Body.writeBytes(LayerData,0,LayerData.length);
			Body.compress();
			var Pack:ByteArray = new ByteArray();
			Pack.writeBytes(Header,0,Header.length);
			Pack.writeBytes(Body,0,Body.length);
			
			return Pack;
		}
		public function Decode(Data:ByteArray):void
		{
			var NameLen:uint = Tools.ByteFinder(Data,Common.BYTE_CHAR_END);
			
			_WorldName = Data.readUTFBytes(NameLen);
			Data.readByte();
			
			_WorldColumn = Data.readShort();
			_WorldRow = Data.readShort();
			
			var Partition:uint = Data.readByte();
			var AreaWidth:uint = 0;
			var AreaHeight:uint = 0;
			if(Partition == Common.AREAPARTITION_YES)
			{
				AreaWidth = Data.readShort();
				AreaHeight = Data.readShort();
			}
			
			var Body:ByteArray = new ByteArray();
			Data.readBytes(Body);
			
			Body.uncompress();
			Body.position = 0;
			
			var Len:uint = Body.readInt();
			var LayerData:ByteArray = new ByteArray();
			Body.readBytes(LayerData,0,Len);
			
			_DataGridLayer = new TileStaggeredLayer();
			_DataGridLayer.Decode(LayerData);
			
			LayerData.clear();
			
			Len = Body.readInt();
			Body.readBytes(LayerData,0,Len);
			
			_TerrainLayer = new TileLayer();
			_TerrainLayer.alpha = 0.6;
			_TerrainLayer.Decode(LayerData);
			
			if(Partition == Common.AREAPARTITION_YES)
			{
				_DataGridLayer.AreaPartition(AreaWidth,AreaHeight);
				_TerrainLayer.AreaPartition(AreaWidth,AreaHeight);
			}
			_TerrainLayer.GridShow();
			_DataGridLayer.GridShow();
			
			UpdateDeep();
			_DataGridLayer.Update();
			_TerrainLayer.Update();
			
			_WorldHeight = _WorldRow * (_DataGridLayer.GridTileHeight >> 1);
			_WorldWidth = _WorldColumn * _DataGridLayer.GridTileWidth;
		}
		
		public function Dispose():void
		{
			
		}
	}
}