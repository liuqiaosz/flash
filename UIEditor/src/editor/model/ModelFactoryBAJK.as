package editor.model
{
	/**
	 * 
	 * 数据文件格式定义
	 * 
	 * 1	Short	组件版本
	 * 该组件的版本号
	 * 
	 * 1	Short	组件类型
	 * 组件类型为	0:简单	1:复合	简单组件只能在单一控件基础上进行扩展.而复合组件能够以Panel为基础容器进行多个控件的组合扩展
	 * 
	 * 50	Byte	组件源代码包路径
	 * 
	 * 20	Byte	组件源代码类名
	 * 
	 * 1	Short	控件类型
	 * 当组件类型为0时该域表示整个组件所用控件的类型,因为简单组件就只能在单一控件基础上扩展
	 * 当组件类型为1时该域表示底层容器的控件类型,因为复合组件需要以容器控件为底层进行扩展
	 * 1	Short	控件版本
	 * 1	Short	控件宽度
	 * 1	Short	控件高度
	 * 1	Short	X坐标
	 * 1	Short	Y坐标
	 * 1	Uint	背景颜色
	 * 1	Float	背景透明读
	 * 1	Uint	边框颜色
	 * 1	Float	边框透明度
	 * 1	Short	边框圆角
	 * 1	Short	边框宽度
	 * 1	Short	形状
	 * 形状参数定义为0:矩形	1:圆形	2:椭圆
	 * 1	Short	半径
	 * 当形状为1时该域标识控件绘制的半径
	 * 1	Short	背景图形标识
	 * 0表示没有背景图片,1表示有背景图片
	 * 1	int		图片数据域长度
	 * X			图片数据
	 **/
	public class ModelFactoryBAJK
	{
		private static var _Model:IModel = null;
		public function ModelFactoryBAJK()
		{
			
		}
		
		public static function get Instance():IModel
		{
			if(null == _Model)
			{
				_Model = new ModelParser();
			}
			return _Model;
		}
	}
}

import pixel.ui.control.UIContainer;
import corecom.control.HorizontalPanel;
import corecom.control.IUIControl;
import pixel.ui.control.UIButton;
import pixel.ui.control.UIPanel;
import pixel.ui.control.UISlider;
import pixel.ui.control.UIControl;
import pixel.ui.control.VerticalPanel;
import pixel.ui.control.utility.ControlType;
import pixel.ui.control.utility.Utils;

import editor.model.ComponentModel;
import editor.model.IModel;
import editor.ui.ComponentProfile;
import editor.ui.Shell;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import mx.controls.Alert;
import mx.graphics.codec.PNGEncoder;
import mx.utils.StringUtil;

import utility.Tools;

class ModelParser implements IModel
{
	private var ComponentCache:Vector.<ComponentModel> = new Vector.<ComponentModel>();
	/**
	 * 控件编码
	 * 
	 * @Control:	要进行编码的控件
	 * @Component:	要编码的组件信息
	 **/
	public function Encode(ControlShell:UIControl,Children:Array,Component:ComponentProfile):ByteArray
	{
		
		//var Control:UIControl = ControlShell.Control as UIControl;
		var Data:ByteArray = new ByteArray();
		var ControlModel:ByteArray = null;
		if(ControlShell)
		{
			//组件版本
			Data.writeShort(Component.Version);
			//组件类型
			Data.writeShort(Component.Category);
			
			var Pack:String = Tools.FillChar(Component.PackageName," ",50);
			Data.writeUTFBytes(Pack);
			
			var Cls:String = Tools.FillChar(Component.ClassName," ",20);
			Data.writeUTFBytes(Cls);
			
			//组件映射数据
			var ComponentSymbol:Dictionary = new Dictionary();
			var SymbolCount:int = 0;
			var Container:UIControl = ControlShell;
			
			if(Component.Category == 1)
			{
				var ChildShell:Shell = null;
				var ChildControl:UIControl = null;
				//Data.writeByte(Children.length);
				//复合组件.需要依次对子组件进行编码	
				for(var Idx:int=0; Idx<Children.length; Idx++)
				{
					ChildShell = Children[Idx];
					if(ChildShell.IsComponent)
					{
						ComponentSymbol[Idx] = ChildShell.Component;
						SymbolCount++;
					}
					ChildControl = ChildShell.Control as UIControl;
					ChildControl.x = ChildShell.x;
					ChildControl.y = ChildShell.y;
					//ControlModel = ChildControl.Encode();
					//ChildControl.x = 0;
					//ChildControl.y = 0;
					//ControlModel.position = 0;
					//Data.writeBytes(ControlModel,0,ControlModel.bytesAvailable);
					Container.addChild(ChildControl);
				}
			}
			
			//组件映射数量
			Data.writeByte(SymbolCount);
			if(SymbolCount > 0)
			{
				var Com:ComponentModel = null;
				for(var Key:* in ComponentSymbol)
				{
					Com = ComponentSymbol[Key];
					//组件所处序列下标
					Data.writeByte(int(Key));
					//写入包路径
					Data.writeUTFBytes(Tools.FillChar(Com.PackageName," ",50));
					//写入类路径
					Data.writeUTFBytes(Tools.FillChar(Com.ClassName," ",50));
				}
			}
			ControlModel = Container.Encode();
			
			Data.writeBytes(ControlModel,0,ControlModel.length);
		}
		return Data;
	}
//	public function Encode(ControlShell:Shell,Children:Array,Component:ComponentProfile):ByteArray
//	{
//		
//		//var Control:UIControl = ControlShell.Control as UIControl;
//		var Data:ByteArray = new ByteArray();
//		var ControlModel:ByteArray = null;
//		if(ControlShell)
//		{
//			//组件版本
//			Data.writeShort(Component.Version);
//			//组件类型
//			Data.writeShort(Component.Category);
//			
//			var Pack:String = Tools.FillChar(Component.PackageName," ",50);
//			Data.writeUTFBytes(Pack);
//			
//			var Cls:String = Tools.FillChar(Component.ClassName," ",20);
//			Data.writeUTFBytes(Cls);
//			
//			//组件映射数据
//			var ComponentSymbol:Dictionary = new Dictionary();
//			var SymbolCount:int = 0;
//			var Container:UIControl = ControlShell.Control as UIControl;
//			
//			if(Component.Category == 1)
//			{
//				var ChildShell:Shell = null;
//				var ChildControl:UIControl = null;
//				//Data.writeByte(Children.length);
//				//复合组件.需要依次对子组件进行编码	
//				for(var Idx:int=0; Idx<Children.length; Idx++)
//				{
//					ChildShell = Children[Idx];
//					if(ChildShell.IsComponent)
//					{
//						ComponentSymbol[Idx] = ChildShell.Component;
//						SymbolCount++;
//					}
//					ChildControl = ChildShell.Control as UIControl;
//					ChildControl.x = ChildShell.x;
//					ChildControl.y = ChildShell.y;
//						//ControlModel = ChildControl.Encode();
//						//ChildControl.x = 0;
//						//ChildControl.y = 0;
//						//ControlModel.position = 0;
//						//Data.writeBytes(ControlModel,0,ControlModel.bytesAvailable);
//					Container.addChild(ChildControl);
//				}
//			}
//			
//			//组件映射数量
//			Data.writeByte(SymbolCount);
//			if(SymbolCount > 0)
//			{
//				var Com:ComponentModel = null;
//				for(var Key:* in ComponentSymbol)
//				{
//					Com = ComponentSymbol[Key];
//					//组件所处序列下标
//					Data.writeByte(int(Key));
//					//写入包路径
//					Data.writeUTFBytes(Tools.FillChar(Com.PackageName," ",50));
//					//写入类路径
//					Data.writeUTFBytes(Tools.FillChar(Com.ClassName," ",50));
//				}
//			}
//			ControlModel = Container.Encode();
//			
//			Data.writeBytes(ControlModel,0,ControlModel.length);
//		}
//		return Data;
//	}
	
	/**
	 * 控件解码
	 **/
	public function Decode(Model:ByteArray):ComponentModel
	{
		
		try
		{
			Model.position = 0;
			var Component:ComponentModel = ReadComponent(Model);
			Component.ModelByte = Model;
			ComponentCache.push(Component);
			if(Component.Control is UIPanel)
			{
				Component.Container = 0;
			}
			if(Component.Category == 1)
			{
				var Child:UIControl = null;
				var Len:int = UIContainer(Component.Control).Children.length;
				for(var Idx:int=0; Idx<Len; Idx++)
				{
					Child = UIContainer(Component.Control).Children.shift();
					Component.Control.removeChild(Child);
					Component.Children.push(Child);
				}
			}
		}
		catch(Err:Error)
		{
			Alert.show(Err.message);
		}
		return Component;
	}
	
	/**
	 * 通过类名和包名查找组件模型
	 * 
	 **/
	public function FindModelByFullName(Pack:String,ClassName:String):ComponentModel
	{
		for(var Idx:int=0; Idx<ComponentCache.length; Idx++)
		{
			if(ComponentCache[Idx].PackageName == Pack && ComponentCache[Idx].ClassName == ClassName)
			{
				return ComponentCache[Idx];
			}
		}
		return null;
	}
	
	private function ModelCopy(Model:ByteArray):ByteArray
	{
		var Data:ByteArray = new ByteArray();
		Data.writeBytes(Model,0,Model.length);
		Data.position = 0;
		return Data;
	}
	
//	private static function WriteControl(ControlShell:Shell):ByteArray
//	{
//		var Control:UIControl = ControlShell.Control as UIControl;
//		var Data:ByteArray = new ByteArray();
//		if(Control)
//		{
//			//实例Id
//			var Id:String = Control.Id;
//			if(Id.length < 20)
//			{
//				Id = Tools.FillChar(Id," ",20);
//			}
//			Data.writeUTFBytes(Id);
//			//1	Short	控件类型
//			Data.writeByte(Utils.GetControlPrototype(Control));
//			//1	Short	控件版本
//			Data.writeShort(Control.Version);
//			//1	Short	X
//			Data.writeShort(ControlShell.x);	//外壳的X
//			//1	Short	Y
//			Data.writeShort(ControlShell.y);	//外壳的Y
//			var StyleData:ByteArray = Control.Style.Encode();
//			Data.writeBytes(StyleData,0,StyleData.length);
//		}
//		return Data;
//	}
	
	private function ReadComponent(Model:ByteArray):ComponentModel
	{
		var Control:UIControl = null;
		var Component:ComponentModel = new ComponentModel();
		try
		{
			
			//获取组件版本
			var Version:int = Model.readShort();
			//组件类型
			var Category:int = Model.readShort();
			
			Component.PackageName = StringUtil.trim(Model.readUTFBytes(50));
			Component.ClassName = StringUtil.trim(Model.readUTFBytes(20));
			
			var SymbolCount:int = Model.readByte();
			for(var Idx:int=0; Idx<SymbolCount; Idx++)
			{
				var Index:int = Model.readByte();
				var Pack:String = Model.readUTFBytes(50);
				var cls:String = Model.readUTFBytes(50);
				Component.Symbol[Index] = Pack + cls;
			}
			
			//Component.Control = Control;
			Component.Category = Category;
			Component.Version = Version;
			Component.ModelByte = ModelCopy(Model);
			//var Control:UIControl = ReadControl(Model);
			
			var Type:int = Model.readByte();
			//var Id:String = Model.readUTFBytes(20);
			
			//1	Short	控件类型
			switch(Type)
			{
				case ControlType.SIMPLEBUTTON:
					Control = new UIButton();
					break;
				case ControlType.SIMPLEPANEL:
					Control = new UIPanel();
					break;
				case ControlType.HORIZONTALPANEL:
					Control = new HorizontalPanel();
					break;
				case ControlType.VERTICALPANEL:
					Control = new VerticalPanel();
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
			}
			if(Control)
			{
				Control.Decode(Model);
			}
			
			Component.Control = Control;
		}
		catch(Err:Error)
		{
			trace(Err.message);
			throw Err;
		}
		return Component;
	}
}