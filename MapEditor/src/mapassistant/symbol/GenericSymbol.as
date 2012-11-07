package mapassistant.symbol
{
	import flash.utils.ByteArray;
	
	import utility.ISerializable;

	/**
	 * 元件基类
	 **/
	public class GenericSymbol implements ISerializable
	{
		//元件类型
		public static const TYPE_IMAGE_2D:uint = 0;
		public static const TYPE_IMAGE_3D:uint = 1;
		public static const TYPE_SOUND_MP3:uint = 2;
		public static const TYPE_SPRITE:uint = 3;				//精灵序列
		
		//资源映射类型
		public static const ASSET_SWF:uint = 0;
		public static const ASSET_FILE:uint = 0;
		
		//资源链接类型
		public static const LINK_SWF:uint = 0;
		public static const LINK_FILE:uint = 1;
		
		//默认连接类型来源是文件
		protected var _LinkType:uint = LINK_SWF;
		public function set LinkType(Value:uint):void
		{
			_LinkType = Value;
		}
		public function get LinkType():uint
		{
			return _LinkType;
		}
		protected var _Version:uint = 0;
		public function set Version(Value:uint):void
		{
			_Version = Value;
		}
		public function get Version():uint
		{
			return _Version;
		}
		
		protected var _Type:uint = TYPE_IMAGE_2D;
		public function set Type(Value:uint):void
		{
			_Type = Value;
		}
		public function get Type():uint
		{
			return _Type;
		}
		
		private var _Title:String = "";
		public function set Title(Value:String):void
		{
			_Title = Value;
		}
		public function get Title():String
		{
			return _Title;
		}
		
		public function GenericSymbol(Type:uint)
		{
			_Type = Type;
		}
		
		private var _Swf:String = "";
		public function set Swf(Value:String):void
		{
			_Swf = Value;
		}
		public function get Swf():String
		{
			return _Swf;
		}
		
		private var _OffsetX:int = 0;
		public function set OffsetX(Value:int):void
		{
			_OffsetX = Value;
		}
		public function get OffsetX():int
		{
			return _OffsetX;
		}
		private var _OffsetY:int = 0;
		public function set OffsetY(Value:int):void
		{
			_OffsetY = Value;
		}
		public function get OffsetY():int
		{
			return _OffsetY;
		}
		
		//当Link类型为SWF时.该参数为资源在SWF里面的Id.如果Link类型为File时该参数为文件的绝对路径
		private var _Class:String = "";
		public function set Class(Value:String):void
		{
			_Class = Value;
		}
		public function get Class():String
		{
			return _Class;
		}
		
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			Data.writeByte(_Version);
			Data.writeByte(_Type);
			Data.writeByte(_LinkType);
			if(_LinkType == LINK_SWF)
			{
				Data.writeInt(_Swf.length);
				Data.writeUTFBytes(_Swf);
			}
			Data.writeInt(_Class.length);
			Data.writeUTFBytes(_Class);
			return Data;
		}
		
		public function Decode(Data:ByteArray):void
		{
			_Version = Data.readByte();
			_Type = Data.readByte();
			_LinkType = Data.readByte();
			var Len:int = 0;
			if(_LinkType == LINK_SWF)
			{
				Len = Data.readInt();
				if(Len > 0)
				{
					_Swf = Data.readUTFBytes(Len);
				}
			}
			Len = Data.readInt();
			if(Len > 0)
			{
				_Class = Data.readUTFBytes(Len);
				_Title = _Class;
			}
		}
	}
}