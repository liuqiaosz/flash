package game.sdk.map.tile
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import game.sdk.map.CoordinateTools;
	import game.sdk.math.astar.AstarNode;
	
	import utility.ISerializable;

	public class TileData
	{
		//public var Mode:uint = TileMode.TILE_3D;
//		public var _Size:uint = 0;
//		public function set Size(Value:uint):void
//		{
//			_Size = Value;
//		}
//		public function get Size():uint
//		{
//			return _Size;
//		}
		private var _Width:uint = 0;
		private var _Height:uint = 0;
		public function set Width(Value:uint):void
		{
			_Width = Value;
		}
		public function get Width():uint
		{
			return _Width;
		}
		public function set Height(Value:uint):void
		{
			_Height = Value;
		}
		public function get Height():uint
		{
			return _Height;
		}
		public var _Lock:Boolean = false;
		public function set Lock(Value:Boolean):void
		{
			_Lock = Value;
		}
		public function get Lock():Boolean
		{
			return _Lock;
		}
		//public var Type:uint = 0;
		public var _Row:uint = 0;
		public function set Row(Value:uint):void
		{
			_Row = Value;
			_Y = Value * _Height;
		}
		public function get Row():uint
		{
			return _Row;
		}
		public var _Column:uint = 0;
		public function set Column(Value:uint):void
		{
			_Column = Value;
		}
		public function get Column():uint
		{
			return _Column;
		}
		public var _BlockColumn:uint = 0;
		public function set BlockColumn(Value:uint):void
		{
			_BlockColumn = Value;
		}
		public function get BlockColumn():uint
		{
			return _BlockColumn;
		}
		public var _BlockRow:uint = 0;
		public function set BlockRow(Value:uint):void
		{
			_BlockRow = Value;
		}
		public function get BlockRow():uint
		{
			return _BlockRow;
		}
//		public var PosX:uint = 0;
//		public var PosY:uint = 0;
//		public var ScreenX:uint = 0;
//		public var ScreenY:uint = 0;
//		public var LogicX:uint = 0;
//		public var LogicY:uint = 0;
		//public var Walk:Boolean = false;
		//数据格状态-默认锁定
		public var _State:uint = TileMode.TILE_STATE_LOCK;
		public function set State(Value:uint):void
		{
			_State = Value;
		}
		public function get State():uint
		{
			return _State;
		}
		public var _Mode:uint = TileMode.TILE_EMPTY;
		public function set Mode(Value:uint):void
		{
			_Mode = Value;
		}
		public function get Mode():uint
		{
			return _Mode;
		}
//		public var Tile:GenericTile = null;
//		public var ResourceMode:uint = 0;
		public var _ResourceId:String = "";
		public function set ResourceId(Value:String):void
		{
			_ResourceId = Value;
		}
		public function get ResourceId():String
		{
			return _ResourceId;
		}
		public var _ResourceClass:String = "";
		public function set ResourceClass(Value:String):void
		{
			_ResourceClass = Value;
		}
		public function get ResourceClass():String
		{
			return _ResourceClass;
		}
		//public var ResourceURL:String = "";
		public var _Resource:BitmapData = null;
		public function set Resource(Value:BitmapData):void
		{
			_Resource = Value;
		}
		public function get Resource():BitmapData
		{
			return _Resource;
		}
		private var _AstarNode:AstarNode = null;
		
		public function get Node():AstarNode
		{
			if(_AstarNode == null)
			{
				//_AstarNode = new AstarNode(Row,Column,_Width,_Height,Boolean(State));
				_AstarNode = new AstarNode(Row,Column,_Width,_Height,true);
			}
			return _AstarNode;
		}
		
		private var _X:uint = 0;
		public function get X():uint
		{
			return _X;
		}
		public function set X(Value:uint):void
		{
			_X = Value;
		}
		private var _Y:uint = 0;
		public function get Y():uint
		{
			return _Y;
		}
		public function set Y(Value:uint):void
		{
			_Y = Value;
		}
		
		public function get DiamondPosition():Position2D
		{
			return CoordinateTools.Get2dByIsoPosition(this._Row * _Height,0,this.Column * _Height);
		}
//		
//		public function Initializer():void
//		{
//			_X = Column * _Width;
//			_Y = Row * Size; 
//		}
		
//		public function Encode():ByteArray
//		{
//			var Data:ByteArray = new ByteArray();
//			
//			//Data.writeByte(Mode);
//			Data.writeShort(Size);
//			//Data.writeByte(int(Lock));
//			//Data.writeByte(Type);
//			Data.writeShort(Column);
//			Data.writeShort(Row);
////			Data.writeShort(PosX);
////			Data.writeShort(PosY);
////			Data.writeShort(ScreenX);
////			Data.writeShort(ScreenY);
////			Data.writeShort(LogicX);
////			Data.writeShort(LogicY);
//			Data.writeByte(State);
//			Data.writeByte(Mode);
////			Data.writeByte(ResourceMode);
//			Data.writeByte(ResourceId.length);
//			Data.writeUTFBytes(ResourceId);
//			Data.writeByte(ResourceClass.length);
//			Data.writeUTFBytes(ResourceClass);
//			//Data.writeShort(ResourceURL.length);
//			//Data.writeUTFBytes(ResourceURL);
//			return Data;
//		}
//		public function Decode(Data:ByteArray):void
//		{
//			//Mode = Data.readByte();
//			Size = Data.readShort();
//			//Lock = Boolean(Data.readByte());
//			//Type = Data.readByte();
//			Column = Data.readShort();
//			Row = Data.readShort();
//			//PosX = Data.readShort();
//			//PosY = Data.readShort();
//			//ScreenX = Data.readShort();
//			//ScreenY = Data.readShort();
////			LogicX = Data.readShort();
////			LogicY = Data.readShort();
//			State = Data.readByte();
//			Mode = Data.readByte();
//			//ResourceMode = Data.readByte();
//			var Len:int = Data.readByte();
//			ResourceId = Data.readUTFBytes(Len);
//			Len = Data.readByte();
//			ResourceClass = Data.readUTFBytes(Len);
//			
//			_X = Column * Size;
//			_Y = Row * Size;
//			//Len = Data.readShort();
//			//ResourceURL = Data.readUTFBytes(Len);
//		}
	}
}