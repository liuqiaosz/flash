package pixel.ui.control.vo
{
	import flash.utils.ByteArray;
	
	import pixel.utility.ISerializable;

	public class ColorFormat implements ISerializable
	{
		private var _color:uint = 0;
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			return _color;
		}
		private var _size:int = 12;
		public function set size(value:int):void
		{
			_size = value;
		}
		public function get size():int
		{
			return _size;
		}
		private var _isLink:Boolean = false;
		public function set isLink(value:Boolean):void
		{
			_isLink = value;
		}
		public function get isLink():Boolean
		{
			return _isLink;
		}
		private var _linkId:String = "";
		public function set linkId(value:String):void
		{
			_linkId = value;
		}
		public function get linkId():String
		{
			return _linkId;
		}
		
		private var _startIndex:int = 0;
		public function set startIndex(value:int):void
		{
			_startIndex = value;
		}
		public function get startIndex():int
		{
			return _startIndex;
		}
		private var _endIndex:int = 0;
		public function set endIndex(value:int):void
		{
			_endIndex = value;
		}
		public function get endIndex():int
		{
			return _endIndex;
		}
		public function ColorFormat()
		{
		}
		
		public function encode():ByteArray
		{
			var data:ByteArray = new ByteArray();
			data.writeUnsignedInt(_color);
			data.writeByte(_size);
			data.writeByte(int(_isLink));
			data.writeUTF(_linkId);
			data.writeShort(_startIndex);
			data.writeShort(_endIndex);
			return data;
		}
		public function decode(data:ByteArray):void
		{
			_color = data.readUnsignedInt();
			_size = data.readByte();
			_isLink = Boolean(data.readByte());
			_linkId = data.readUTF();
			_startIndex = data.readShort();
			_endIndex = data.readShort();
		}
	}
}