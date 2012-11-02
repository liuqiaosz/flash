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
import corecom.control.UIPanel;
import corecom.control.UISlider;
import corecom.control.asset.IControlAssetManager;
import corecom.control.utility.ControlType;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;

class UIControlFactoryImpl extends EventDispatcher implements IUIControlFactory
{
	public function Encode(Control:IUIControl):ByteArray
	{
		return null;
	}
	public function Decode(Data:ByteArray):IUIControl
	{
		//获取组件版本
		var Version:int = Data.readShort();
		//组件类型
		var Category:int = Data.readShort();
		
		//var Len:int = Data.readByte();
		
		//var PackName:String = Data.readUTFBytes(50);
		//var ClassName:String = Data.readUTFBytes(20);

		var Type:int = Data.readByte();
		var Control:IUIControl = null;
		switch(Type)
		{
			case ControlType.SIMPLEBUTTON:
				Control = new UIButton();
				break;
			case ControlType.SIMPLEPANEL:
				Control = new UIPanel();
				break;
//			case ControlType.HORIZONTALPANEL:
//				Control = new HorizontalPanel();
//				break;
//			case ControlType.VERTICALPANEL:
//				Control = new VerticalPanel();
			case ControlType.SLIDER:
				Control = new UISlider();
				//				case ControlType.CUSTOMER:
				//					//自定义组件类型,查找当前加载的自定义组件库,匹配自定义组件
				//					var CustomPack:String = StringUtil.trim(Model.readUTFBytes(50));
				//					var CustomClass:String = StringUtil.trim(Model.readUTFBytes(50));
				//					
				//					var CustomComponent:ComponentModel = this.FindModelByFullName(CustomPack,CustomClass);
				//					if(CustomComponent)
				//					{
				//						CustomComponent = Decode(this.ModelCopy(CustomComponent.ModelByte));
				//						if(CustomComponent)
				//						{
				//							Control = CustomComponent.Control;
				//						}
				//					}
				//					break;
				break;
			
		}
		if(Control)
		{
			Control.Decode(Data);
		}
		return Control;
	}
}