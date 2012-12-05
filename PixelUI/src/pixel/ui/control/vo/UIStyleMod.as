package pixel.ui.control.vo
{
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.utility.Utils;
	import pixel.utility.Tools;

	public class UIStyleMod
	{
		private var _id:String = "";
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		
		private var _style:IVisualStyle = null;
		public function set style(value:IVisualStyle):void
		{
			_style = value;
		}
		public function get style():IVisualStyle
		{
			return _style;
		}
		
		private var _desc:String = "";
		public function set desc(value:String):void
		{
			_desc = value;
		}
		public function get desc():String
		{
			return _desc;
		}
		
		public function get styleName():String
		{
			return Utils.getStyleNameByType(Utils.getStyleTypeByPrototype(_style));
		}
		
		public function UIStyleMod()
		{
		}
		
		public function encode():ByteArray
		{
			var data:ByteArray = new ByteArray();
			
			data.writeByte(Utils.getStyleTypeByPrototype(_style));
			data.writeByte(_id.length);
			data.writeUTFBytes(_id);
			
			var len:int = Tools.StringActualLength(_desc);
			data.writeByte(len);
			if(len > 0)
			{
				data.writeMultiByte(_desc,"cn-gb");
			}
			data.writeBytes(_style.Encode());
			return data;
		}
		
		public function decode(data:ByteArray):void
		{
			var prototype:Class = Utils.getStylePrototypeByType(data.readByte());
			if(!prototype)
			{
				throw new Error("Error style type");	
			}
			_style = new prototype() as IVisualStyle;
			var len:int = data.readByte();
			_id = data.readUTFBytes(len);
			len = data.readByte();
			if(len > 0)
			{
				_desc = data.readMultiByte(len,"cn-gb");
			}
			_style.Decode(data);
		}
	}
}