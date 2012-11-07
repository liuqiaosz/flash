package mapassistant.map.world
{
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.map.tile.TileData;
	
	import utility.ColorCode;
	
	/**
	 * 支持分区数据层
	 **/
	public class AreaPartitionLayer extends GenericLayer
	{
		public function AreaPartitionLayer(Row:uint = 0,Column:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super(Row,Column,TileWidth,TileHeight);
		}
		
		//分隔状态
		protected var _HasPartition:Boolean = false;
		public function get HasPartition():Boolean
		{
			return _HasPartition;
		}
		protected var _AreaWidth:uint = 0;
		public function get AreaWidth():uint
		{
			return _AreaWidth;
		}
		protected var _AreaHeight:uint = 0;
		public function get AreaHeight():uint
		{
			return _AreaHeight;
		}
		protected var _AreaColumn:uint = 0;
		public function get AreaColumn():uint
		{
			return _AreaColumn;
		}
		protected var _AreaRow:uint = 0;
		public function get AreaRow():uint
		{
			return _AreaRow;
		}
		//每个区块里面的Tile行,列
		protected var _AreaTileColumn:int = 0;
		protected var _AreaTileRow:int = 0;
		
		protected var _AtAreaColumn:int = 0;
		
		protected var _AtAreaRow:int = 0;
		
		protected var _WorldName:String = "";
		public function set WorldName(Value:String):void
		{
			_WorldName = Value;
		}
		public function get WorldName():String
		{
			return _WorldName;
		}
		
		public function AreaPartition(AreaWidth:uint,AreaHeight:uint):void
		{
			_AreaWidth = AreaWidth;
			_AreaHeight = AreaHeight;
			
			_AreaTileColumn = _AreaWidth / _GridTileWidth;
			_AreaTileRow = _AreaHeight / _GridTileHeight;
			
			_AreaColumn = _LayerWidth / _AreaWidth;
			_AreaRow = _LayerHeight / _AreaHeight;
			
			_HasPartition = true;
			//默认当前视图是第一区块
			SetArea(0,0);
		}
		
		private var _AreaGrid:Vector.<Vector.<TileData>> = null;
		private var _AreaQueue:Vector.<TileData> = null;
		/**
		 * 设置当前层所处的区块数据组
		 **/
		public function SetArea(Column:int,Row:int):void
		{
			if(_HasPartition && Column < _AreaColumn && Row < _AreaRow)
			{
				_AtAreaColumn = Column;
				_AtAreaRow = Row;
				var ColIdx:int = _AtAreaColumn * _AreaTileColumn;
				var RowIdx:int = _AtAreaRow * _AreaTileColumn;
				_AreaGrid = new Vector.<Vector.<TileData>>(_AreaTileRow);
				_AreaQueue = new Vector.<TileData>();
				var TotalGrid:Vector.<Vector.<TileData>> = super.Grid;
				for(var Row:int=0; Row<_AreaTileRow; Row++)
				{
					_AreaGrid[Row] = new Vector.<TileData>(_AreaTileColumn);
					for(var Col:int = 0; Col<_AreaTileColumn; Col++)
					{
						_AreaGrid[Row][Col] = TotalGrid[RowIdx + Row][ColIdx + Col];
						_AreaGrid[Row][Col].BlockColumn = Col;
						_AreaGrid[Row][Col].BlockRow = Row;
						_AreaQueue.push(_AreaGrid[Row][Col]);
					}
				}
				Update();
			}
		}
		
		override public function get GridQueue():Vector.<TileData>
		{
			if(_HasPartition)
			{
				return _AreaQueue;
			}
			else
			{
				return super.GridQueue;
			}
		}
		
		override public function get Grid():Vector.<Vector.<TileData>>
		{
			if(_HasPartition)
			{
				return _AreaGrid;
			}
			else
			{
				return super.Grid;
			}
		}
		
		public function GridShow():void
		{
			_GridShow = true;
			Update();
		}
		public function GridHide():void
		{
			_GridShow = false;
			Update();
		}
		
		//网格是否显示
		protected var _GridShow:Boolean = false;
		//网格线宽度
		protected var _GridThinkness:uint = 1;
		//网格线颜色
		protected var _GridLineColor:uint = ColorCode.GRAY;
		//网格线透明度
		protected var _GridLineAlpha:Number = 1;
		//网格填充颜色
		protected var _GridFillColor:uint = ColorCode.WHITE;
		//网格填充透明度
		protected var _GridFillAlpha:Number = 1;
	}
}