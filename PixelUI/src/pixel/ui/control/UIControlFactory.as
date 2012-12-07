package pixel.ui.control
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.vo.UIMod;

	public class UIControlFactory extends EventDispatcher
	{
		private static var _instance:UIControlFactory = new UIControlFactory;
		public function UIControlFactory()
		{
			if(!_instance)
			{
				throw new Error("Singlton");
			}
		}
		
		public static function get instance():UIControlFactory
		{
			return _instance;
		}
		
		public function encode(mod:UIMod):ByteArray
		{
			return null;
		}
//		public static function get Instance():IUIControlFactory
//		{
//			if(_Instance == null)
//			{
//				_Instance = new UIControlFactoryImpl();
//			}
//			return _Instance;
//		}
	}
}

import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import flashx.textLayout.events.ModelChange;

import pixel.ui.control.IUIControl;
import pixel.ui.control.IUIControlFactory;
import pixel.ui.control.UIButton;
import pixel.ui.control.UIControl;
import pixel.ui.control.UIPanel;
import pixel.ui.control.UISlider;
import pixel.ui.control.asset.IPixelAssetManager;
import pixel.ui.control.style.IVisualStyle;
import pixel.ui.control.utility.Utils;
import pixel.ui.control.vo.UIControlMod;
import pixel.ui.control.vo.UIMod;
import pixel.ui.control.vo.UIStyleMod;
import pixel.ui.core.NSPixelUI;

use namespace NSPixelUI;
class UIControlFactoryImpl extends EventDispatcher implements IUIControlFactory
{
	public function Encode(Control:IUIControl):ByteArray
	{
		return null;
	}
	
	public function encode(mod:UIMod):ByteArray
	{
		var controls:Vector.<UIControlMod> = mod.controls;
		var styles:Vector.<UIStyleMod> = mod.styles;
		var data:ByteArray = new ByteArray();
		
		data.writeBytes(styleEncode(styles));
		
		//写入组件数据
		data.writeShort(controls.length);
		var idx:int = 0;
		var child:ByteArray = null;
		var controlData:ByteArray = new ByteArray();
		var idData:ByteArray = new ByteArray();
		var mapData:ByteArray = new ByteArray();
		var control:UIControl = null;
		for(idx = 0; idx<controls.length; idx++)
		{
			control = controls[idx].control as UIControl;
			
			//组件ID写入
			idData.writeByte(control.Id.length);
			idData.writeUTFBytes(control.Id);
			
			//组件，样式映射关系写入
			if(control.styleLinked)
			{
				var linkIdx:int = styles.indexOf(control.linkStyle);
				mapData.writeByte(idx);
				mapData.writeByte(linkIdx);
			}
			
			child = controls[idx].control.Encode();
			controlData.writeInt(child.length);
			controlData.writeBytes(child);
		}
		data.writeBytes(mapData);
		data.writeBytes(idData);
		data.writeBytes(controlData);
		
		return data;
	}
	
	private function styleEncode(styles:Vector.<UIStyleMod>):ByteArray
	{
		var data:ByteArray = new ByteArray();
		var style:UIStyleMod = null;
		data.writeByte(styles.length);
		var styleData:ByteArray = new ByteArray();
		var encoded:ByteArray = null;
		for each(style in styles)
		{
			data.writeByte(style.id.length);
			data.writeUTFBytes(style.id);
			encoded = style.encode();
			styleData.writeInt(encoded.length);
			styleData.writeBytes(encoded);
		}
		
		data.writeBytes(styleData);
		return data;
	}
	
	public function styleDecode(data:ByteArray):Vector.<UIStyleMod>
	{
		var count:int = data.readByte();
		var len:int = 0;
		var ids:Vector.<String> = new Vector.<String>();
		var id:String = "";
		var idx:int = 0;
		var styles:Vector.<UIStyleMod> = new Vector.<UIStyleMod>();
		for(idx; idx<count; idx++)
		{
			len = data.readByte();
			id = data.readUTFBytes(len);
			ids.push(id);
		}
		
		var styleData:ByteArray = null;
		for(idx = 0; idx<count; idx++)
		{
			len = data.readInt();
			styleData = new ByteArray();
			data.readBytes(styleData,0,len);
			var mod:UIStyleMod = new UIStyleMod(styleData);
			mod.id = ids[idx];
			styles.push(mod);
		}
		
		return styles;
	}
	
	
	public function Decode(Data:ByteArray):UIMod
	{
		var Len:int = 0;
		var mod:UIMod = new UIMod();
		var Vec:Vector.<IUIControl> = new Vector.<IUIControl>();
		var styleMap:Dictionary = new Dictionary();
		var count:int = 0;
		//独立样式定义
		var prototype:Class = null;
		var child:ByteArray = null;
		
		var styles:Vector.<UIStyleMod> = styleDecode(Data);
		
		for each(var style:UIStyleMod in styles)
		{
			styleMap[style.id] = style;
		}
		
		count = Data.readShort();
		
		var idx:int = 0;
		var ids:Vector.<String> = new Vector.<String>();
		for(idx; idx<count; idx++)
		{
			Len = Data.readByte();
			ids.push(Data.readUTFBytes(Len));
		}
		
		var controlData:ByteArray = null;
		var controlMod:UIControlMod = null;
		for(idx = 0; idx<count; idx++)
		{
			controlData = new ByteArray();
			Len = Data.readInt();
			Data.readBytes(controlData,0,Len);
			controlMod = new UIControlMod();
			controlMod.source = controlData;
		}
		
		var Child:ByteArray = new ByteArray();
		var Type:int = 0;
		var Control:IUIControl = null;
		var controlMod:UIControlMod = null;
		for(var Idx:int = 0; Idx<count; Idx++)
		{
			Len = Data.readInt();
			Data.readBytes(Child,0,Len);
			controlMod = new UIControlMod();
			controlMod.source = Child;
			Type = Child.readByte();
			prototype = Utils.GetPrototypeByType(Type);
			if(prototype)
			{
				Control = new prototype() as IUIControl;
				if(Control)
				{
					Control.Decode(Child);
					if(UIControl(Control).styleLinked)
					{
						var styleId:String = UIControl(Control).styleLinkId;
						if(styleId in styleMap)
						{
							UIControl(Control).Style = styleMap[styleId].style;
						}
						else
						{
							
						}
					}
					Vec.push(Control);
				}
			}
			Child.position = 0;
		}
		
		mod = new UIMod(Vec,styles);
		return mod;
	}
}