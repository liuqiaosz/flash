package pixel.ui.control.style
{
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI;
	
	public class UIStyleFactory
	{
		private static var _instance:UIStyleFactoryImpl = null;
		public function UIStyleFactory()
		{
		}
		
		public static function get instance():IUIStyleFactory
		{
			if(!_instance)
			{
				_instance = new UIStyleFactoryImpl();
			}
			return _instance;
		}
	}
}
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;

import pixel.ui.control.style.IUIStyleFactory;
import pixel.ui.control.vo.UIStyleGroup;
import pixel.ui.control.vo.UIStyleMod;
import pixel.utility.Tools;

class UIStyleFactoryImpl extends EventDispatcher implements IUIStyleFactory
{
	public function encode(styles:Vector.<UIStyleMod>):ByteArray
	{
		var data:ByteArray = new ByteArray();
		var style:UIStyleMod = null;
		data.writeByte(styles.length);
		var styleData:ByteArray = new ByteArray();
		var encoded:ByteArray = null;
		for each(style in styles)
		{
			styleData.writeByte(style.id.length);
			styleData.writeUTFBytes(style.id);
			encoded = style.encode();
			styleData.writeInt(encoded.length);
			styleData.writeBytes(encoded);
		}
		
		data.writeBytes(styleData);
		return data;
	}
	
	public function decode(data:ByteArray):Vector.<UIStyleMod>
	{
		
		var count:int = data.readByte();
		var styleData:ByteArray = null;
		var id:String = "";
		var style:UIStyleMod = null;
		var styles:Vector.<UIStyleMod> = new Vector.<UIStyleMod>();
		var len:int = 0;
		for(var idx:int = 0; idx<count; idx++)
		{
			len = data.readByte();
			id = data.readUTFBytes(len);
			len = data.readInt();
			styleData = new ByteArray();
			data.readBytes(styleData,0,len);
			style = new UIStyleMod();
			style.decode(styleData);
			style.id = id;
			styles.push(style);
		}
		return styles;
	}
	
	public function groupEncode(group:UIStyleGroup):ByteArray
	{
		var data:ByteArray = new ByteArray();
		var len:int = group.id.length;
		data.writeByte(len);
		data.writeUTFBytes(group.id);
		
		len = Tools.StringActualLength(group.desc);
		data.writeShort(len);
		data.writeMultiByte(group.desc,"cn-gb");
		
		data.writeBytes(encode(group.styles));
		
		return data;
	}
	public function groupDecode(data:ByteArray):UIStyleGroup
	{
		var group:UIStyleGroup = new UIStyleGroup();
		var len:int = data.readByte();
		group.id = data.readUTFBytes(len);
		
		len = data.readShort();
		group.desc = data.readMultiByte(len,"cn-gb");
		
		var styles:Vector.<UIStyleMod> = decode(data);
		group.styles = styles;
		return group;
	}
}