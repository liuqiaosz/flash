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

import flashx.textLayout.events.ModelChange;

import pixel.ui.control.IUIControl;
import pixel.ui.control.IUIControlFactory;
import pixel.ui.control.UIButton;
import pixel.ui.control.UIPanel;
import pixel.ui.control.UISlider;
import pixel.ui.control.asset.IPixelAssetManager;
import pixel.ui.control.style.IVisualStyle;
import pixel.ui.control.utility.Utils;
import pixel.ui.control.vo.UIMod;
import pixel.ui.control.vo.UIStyleMod;

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
		data.writeShort(controls.length);
		
		var idx:int = 0;
		var child:ByteArray = null;
		for(idx = 0; idx<controls.length; idx++)
		{
			child = controls[idx].Encode();
			data.writeInt(child.length);
			data.writeBytes(child);
		}
		
		data.writeShort(styles.length);
		for(idx=0; idx<styles.length; idx++)
		{
			
			child = styles[idx].encode();
			//child.writeByte(Utils.getStyleTypeByPrototype(styles[idx]));
			//child.writeBytes(styles[idx].Encode());
			data.writeInt(child.length);
			data.writeBytes(child);
		}
		return data;
	}
	public function Decode(Data:ByteArray):UIMod
	{
		var mod:UIMod = new UIMod();
		var Vec:Vector.<IUIControl> = new Vector.<IUIControl>();
		var Count:int = Data.readShort();
		var Len:int = 0;
		var Child:ByteArray = new ByteArray();
		var Type:int = 0;
		var Cls:Object = null;
		var Control:IUIControl = null;
		for(var Idx:int = 0; Idx<Count; Idx++)
		{
			
			Len = Data.readInt();
			Data.readBytes(Child,0,Len);
			
			Type = Child.readByte();
			
			Cls = Utils.GetPrototypeByType(Type);
			
			if(Cls)
			{
				Control = new Cls() as IUIControl;
				if(Control)
				{
//					Control.addEventListener(UIControlEvent.EDIT_LOADRES_OUTSIDE,function(event:UIControlEvent):void{
//						var AssetItem:Asset = Globals.FindAssetByAssetId(event.Message) as Asset;
//						if(null != AssetItem && AssetItem is AssetBitmap)
//						{
//							UIControl(event.target).BackgroundImage = AssetBitmap(AssetItem).Image;
//						}
//						
//					},false,0);
					Control.Decode(Child);
					Vec.push(Control);
				}
			}
			Child.position = 0;
			
		}
		
		var styles:Vector.<UIStyleMod> = new Vector.<UIStyleMod>();
		if(Data.bytesAvailable > 0)
		{
			//独立样式定义
			Count = Data.readShort();
			var prototype:Class = null;
			var child:ByteArray = null;
			for(var index:int = 0; index<Count; index++)
			{
				Len = Data.readInt();
				child = new ByteArray();
				Data.readBytes(child,0,Len);
				var styleMod:UIStyleMod = new UIStyleMod();
				styleMod.decode(child);
				styles.push(styleMod);
			}
		}
		
		mod.controls = Vec;
		mod.styles = styles;
		return mod;
	}
}