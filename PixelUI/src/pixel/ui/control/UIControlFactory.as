package pixel.ui.control
{
	public class UIControlFactory
	{
		private static var _Instance:IUIControlFactory = null;
		public function UIControlFactory()
		{
		}
		
		public static function get Instance():IUIControlFactory
		{
			if(_Instance == null)
			{
				_Instance = new UIControlFactoryImpl();
			}
			return _Instance;
		}
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
		var controls:Vector.<IUIControl> = mod.controls;
		var styles:Vector.<UIStyleMod> = mod.styles;
		var data:ByteArray = new ByteArray();
		
		//写入局部定义样式
		data.writeShort(styles.length);
		for(idx=0; idx<styles.length; idx++)
		{
			child = styles[idx].encode();
			data.writeInt(child.length);
			data.writeBytes(child);
		}
		
		//写入组件数据
		data.writeShort(controls.length);
		var idx:int = 0;
		var child:ByteArray = null;
		for(idx = 0; idx<controls.length; idx++)
		{
			child = controls[idx].Encode();
			data.writeInt(child.length);
			data.writeBytes(child);
		}
		
		
		return data;
	}
	public function Decode(Data:ByteArray):UIMod
	{
		var Len:int = 0;
		var mod:UIMod = new UIMod();
		var Vec:Vector.<IUIControl> = new Vector.<IUIControl>();
		var styles:Dictionary = new Dictionary();
		
		//独立样式定义
		var prototype:Class = null;
		var child:ByteArray = null;
		
		var Count:int = Data.readShort();
		for(var index:int = 0; index<Count; index++)
		{
			Len = Data.readInt();
			child = new ByteArray();
			Data.readBytes(child,0,Len);
			var styleMod:UIStyleMod = new UIStyleMod();
			styleMod.decode(child);
			styles[styleMod.id] = styleMod;
		}
		
		Count = Data.readShort();
		var Child:ByteArray = new ByteArray();
		var Type:int = 0;
		var Control:IUIControl = null;
		for(var Idx:int = 0; Idx<Count; Idx++)
		{
			Len = Data.readInt();
			Data.readBytes(Child,0,Len);
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
						if(styleId in styles)
						{
							UIControl(Control).Style = styles[styleId].style;
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
		
		mod = new UIMod(Vec);
		return mod;
	}
}