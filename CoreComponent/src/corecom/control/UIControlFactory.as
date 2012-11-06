package corecom.control
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

import corecom.control.IUIControl;
import corecom.control.IUIControlFactory;
import corecom.control.UIButton;
import corecom.control.UIControl;
import corecom.control.UIPanel;
import corecom.control.UISlider;
import corecom.control.asset.IControlAssetManager;
import corecom.control.utility.ControlType;
import corecom.control.utility.Utils;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;

class UIControlFactoryImpl extends EventDispatcher implements IUIControlFactory
{
	public function Encode(Control:IUIControl):ByteArray
	{
		return null;
	}
	public function Decode(Data:ByteArray):Vector.<UIControl>
	{
		var Vec:Vector.<UIControl> = new Vector.<UIControl>();
		var Count:int = Data.readShort();
		var Len:int = 0;
		var Child:ByteArray = new ByteArray();
		var Type:int = 0;
		var Cls:Object = null;
		var Control:UIControl = null;
		for(var Idx:int = 0; Idx<Count; Idx++)
		{
			
			Len = Data.readInt();
			Data.readBytes(Child,0,Len);
			
			Type = Child.readByte();
			
			Cls = Utils.GetPrototypeByType(Type);
			
			if(Cls)
			{
				Control = new Cls() as UIControl;
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
		return Vec;
	}
}