package mapassistant.map.world
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import game.sdk.map.tile.TileData;
	import game.sdk.map.tile.TileMode;
	
	import mapassistant.symbol.GenericSymbol;
	import mapassistant.symbol.SymbolFactory;

	public class World extends Sprite
	{
		public static const NORMAL:uint = 0;
		public static const EDIT_WALK:uint = 1;
		public static const EDIT_SYMBOL:uint = 2;
		public static const EDIT_CREATOR:uint = 3;
		public static const EDIT_NPC:uint = 4;
		
		//是否激活连续路点编辑
		protected var _MoveWalkActived:Boolean = false;
		
		protected var _EditMode:uint = 0;
		
		protected var _WorldName:String = "";
		protected var _TileWidth:uint = 0;
		protected var _TileHeight:uint = 0;
		protected var _WorldRow:uint = 0;
		protected var _WorldColumn:uint = 0;
		protected var Mode:int = 0;
		protected var _WorldWidth:int = 0;
		protected var _WorldHeight:int = 0;
		protected var _SymbolClass:String = "";
		protected var _Symbol:GenericSymbol = null;
		
		public function get WorldWidth():uint
		{
			return _WorldWidth;
		}
		public function get WorldHeight():uint
		{
			return _WorldHeight;
		}
		public function set WorldName(Value:String):void
		{
			_WorldName = Value;
		}
		public function get WorldName():String
		{
			return _WorldName;
		}
		public function World(WorldRow:uint,WorldColumn:uint,TileWidth:uint,TileHeight:uint)
		{
			_WorldRow = WorldRow;
			_WorldColumn = WorldColumn;
			_TileWidth = TileWidth;
			_TileHeight = TileHeight;
			_WorldHeight = _WorldRow * _TileHeight;
			_WorldWidth = _WorldColumn * _TileWidth;
		}
		
		/**
		 * 开启路点编辑
		 **/
		public function EnableWalkEidt():void
		{
			_EditMode = EDIT_WALK;
			this.addEventListener(MouseEvent.MOUSE_DOWN,EnableMoveWalk);
			this.addEventListener(MouseEvent.MOUSE_UP,DisableMoveWalk);
		}
		
		/**
		 * 
		 * 激活连续路点编辑
		 **/
		protected function EnableMoveWalk(event:MouseEvent):void
		{
			this._MoveWalkActived = true;
		}
		/**
		 * 取消连续路点编辑
		 **/
		protected function DisableMoveWalk(event:MouseEvent):void
		{
			this._MoveWalkActived = false;
		}
		
		/**
		 * 开启角色创建点编辑模式
		 **/
		public function EnableRoleCreatorEdit():void
		{
			_EditMode = EDIT_CREATOR;
			
		}
		
		/**
		 * 开启元件编辑模式
		 **/
		public function EnableSymbolEdit(Class:String):void
		{
			_EditMode = EDIT_SYMBOL;
			_SymbolClass = Class;
			_Symbol = SymbolFactory.FindSymbolByClass(Class);
		}
		
		/**
		 * 复位当前编辑状态
		 **/
		public function ResetEditMode():void
		{
			//清理上一个状态的监听事件
			switch(_EditMode)
			{
				case EDIT_WALK:
					this.removeEventListener(MouseEvent.MOUSE_DOWN,EnableMoveWalk);
					this.removeEventListener(MouseEvent.MOUSE_UP,DisableMoveWalk);
					break;
			}
			_EditMode = NORMAL;
		}
		
		/**
		 * 设置路经点
		 **/
		public function AddWalk(PosX:uint,PosY:uint):void
		{
			var Tile:TileData = FindTileFromDataGridByScreenPos(PosX,PosY);
			if(Tile)
			{
				//设置点的状态为可行走状态
				Tile.State = TileMode.TILE_STATE_FREE;
				_DataGridLayer.Update();
			}
		}
		
		/**
		 * 获取当前屏幕坐标指向的TILE
		 **/
		public function FindTileFromDataGridByScreenPos(PosX:uint,PosY:uint):TileData
		{
			return null;
		}
		
		public function AreaPartition(AreaWidth:uint,AreaHeight:uint):void
		{
			if(_DataGridLayer)
			{
				_DataGridLayer.AreaPartition(AreaWidth,AreaHeight);
			}
			if(_TerrainLayer)
			{
				_TerrainLayer.AreaPartition(AreaWidth,AreaHeight);
			}
		}
		
		public function SetArea(Column:uint,Row:uint):void
		{
			_DataGridLayer.SetArea(Column,Row);
			if(_TerrainLayer)
			{
				_TerrainLayer.SetArea(Column,Row);
			}
		}
		
		public function get HasPartition():Boolean
		{
			return this._DataGridLayer.HasPartition;
		}
		
		public function get AreaHeight():uint
		{
			return _DataGridLayer.AreaHeight;
		}
		
		public function get AreaWidth():uint
		{
			return _DataGridLayer.AreaHeight;
		}
		
		protected var _TerrainVisible:Boolean = true;
		protected var _DataGridVisible:Boolean = true;
		protected var _ItemVisible:Boolean = true;
		public function ResetOperate():void
		{
			_OperateLayer.RemoveAllChildren();
		}
		
		public function TerrainShowSwitch():void
		{
			ResetOperate();
			_TerrainVisible = !_TerrainVisible;
			_TerrainLayer.visible = _TerrainVisible;
		}
		//		public function TerrainLockSwitch():void
		//		{
		//			ResetOperate();
		//			//_TerrainLock = !_TerrainLock;
		//			if(_TerrainLock)
		//			{
		//				_TerrainLayer.alpha = 0.6;
		//			}
		//			else
		//			{
		//				_TerrainLayer.alpha = 1;
		//			}
		//		}
		
		public function ItemShowSwitch():void
		{
			ResetOperate();
			_ItemVisible = !_ItemVisible;
			_ItemLayer.visible = _ItemVisible;
		}
		//		public function ItemLockSwitch():void
		//		{
		//			ResetOperate();
		//			_ItemLock = !_ItemLock;
		//			if(_ItemLock)
		//			{
		//				_ItemLayer.alpha = 0.6;
		//			}
		//			else
		//			{
		//				_ItemLayer.alpha = 1;
		//			}
		//		}
		
		public function DataGridShowSwitch():void
		{
			ResetOperate();
			_DataGridVisible = !_DataGridVisible;
			_DataGridLayer.visible = _DataGridVisible;
		}
		//		public function DataGridLockSwitch():void
		//		{
		//			ResetOperate();
		//			_DataGridLock = !_DataGridLock;
		//			if(_DataGridLock)
		//			{
		//				_DataGridLayer.alpha = 0.6;
		//			}
		//			else
		//			{
		//				_DataGridLayer.alpha = 1;
		//			}
		//		}
		
		protected var _DataGridLayer:AreaPartitionLayer = null;
		protected var _TerrainLayer:AreaPartitionLayer = null;
		protected var _ItemLayer:AreaPartitionLayer = null;
		protected var _OperateLayer:AreaPartitionLayer = null;
		
		protected function UpdateDeep():void
		{
			if(_DataGridLayer)
			{
				addChild(_DataGridLayer);
			}
			if(_TerrainLayer)
			{
				addChild(_TerrainLayer);
			}
			if(_ItemLayer)
			{
				addChild(_ItemLayer);
			}
			if(_OperateLayer)
			{
				addChild(_OperateLayer);
			}
		}
		
		public function GetTopLayer():AreaPartitionLayer
		{
			if(_ItemVisible && _ItemLayer)
			{
				return _ItemLayer;
			}
			if(_TerrainVisible && _TerrainLayer)
			{
				return _TerrainLayer;
			}
			if(_DataGridVisible &&  _DataGridLayer)
			{
				return _DataGridLayer;
			}
			return null;
		}
	}
}