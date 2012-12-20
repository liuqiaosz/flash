package editor.model
{
	/**
	 * 
	 * 数据文件格式定义
	 * 
	 * 1	Short	组件版本		该组件的版本号
	 * 
	 * 
	 * 1	Short	组件类型		0:简单	1:复合	简单组件只能在单一控件基础上进行扩展.而复合组件能够以Panel为基础容器进行多个控件的组合扩展
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
	public class ModelFactory
	{
		private static var _Model:IModel = null;
		public function ModelFactory()
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
import pixel.ui.control.UIButton;
import pixel.ui.control.UIControl;
import pixel.ui.control.UIImage;
import pixel.ui.control.UILabel;
import pixel.ui.control.UIPanel;
import pixel.ui.control.UISlider;
import pixel.ui.control.UITextInput;
import pixel.ui.control.UIWindow;
import pixel.ui.control.utility.Utils;

import editor.model.ComponentModel;
import editor.model.IModel;
import editor.ui.ComponentProfile;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import mx.controls.Alert;
import mx.graphics.codec.PNGEncoder;
import mx.utils.StringUtil;

import pixel.utility.Tools;

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
		var Data:ByteArray = new ByteArray();
		var ControlModel:ByteArray = null;
		if(ControlShell)
		{
			//组件版本
			Data.writeShort(Component.Version);
			//组件类型
			Data.writeShort(Component.Category);
			
			Data.writeByte(Component.PackageName.length);
			Data.writeUTFBytes(Component.PackageName);
			Data.writeByte(Component.ClassName.length);
			Data.writeUTFBytes(Component.ClassName);
			
			
			ControlModel = ControlShell.encode();
			
			Data.writeBytes(ControlModel,0,ControlModel.length);
		}
		return Data;
	}

	/**
	 * 控件解码
	 **/
	public function Decode(Model:ByteArray):ComponentModel
	{
		
//		try
//		{
//			
//		}
//		catch(Err:Error)
//		{
//			Alert.show(Err.message);
//		}
		Model.position = 0;
		var Component:ComponentModel = ReadComponent(Model);
		Component.ModelByte = Model;
//		ComponentCache.push(Component);
//		if(Component.Control is UIPanel)
//		{
//			Component.Container = 0;
//		}
//		if(Component.Category == 1)
//		{
//			var Child:UIControl = null;
//			var Len:int = Container(Component.Control).Children.length;
//			for(var Idx:int=0; Idx<Len; Idx++)
//			{
//				Child = Container(Component.Control).Children.shift();
//				Component.Control.removeChild(Child);
//				Component.Children.push(Child);
//			}
//		}
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
	
	private function ReadControl(Model:ByteArray,Type:int):UIControl
	{
		var Control:UIControl = null;
		//var Type:int = Model.readByte();
		//var Id:String = Model.readUTFBytes(20);
		
		//1	Short	控件类型
		switch(Type)
		{
			case Utils.SIMPLEBUTTON:
				Control = new UIButton();
				break;
			case Utils.SIMPLEPANEL:
				Control = new UIPanel();
				break;
			case Utils.SLIDER:
				Control = new UISlider();
				break;
			case Utils.LABEL:
				Control = new UILabel();
				break;
			case Utils.TEXTINPUT:
				Control = new UITextInput();
				break;
			case Utils.IMAGE:
				Control = new UIImage();
				break;
			case Utils.WINDOW:
				Control = new UIWindow();
				break;
		}
		if(Control)
		{
			Control.decode(Model);
		}
		return Control;
	}
	
	private function ReadComponent(Model:ByteArray):ComponentModel
	{
		var Control:UIControl = null;
		var Component:ComponentModel = new ComponentModel();
		try
		{
			Component.ModelByte = ModelCopy(Model);
			
			//获取组件版本
			var Version:int = Model.readShort();
			//组件类型
			var Category:int = Model.readShort();
			var Len:int = Model.readByte();
			Component.PackageName = Model.readUTFBytes(Len);
			
			Len = Model.readByte();
			Component.ClassName = Model.readUTFBytes(Len);
			//Component.PackageName = StringUtil.trim(Model.readUTFBytes(50));
			//Component.ClassName = StringUtil.trim(Model.readUTFBytes(20));
			var Type:int = Model.readByte();
			//var SymbolCount:int = Model.readByte();
//			for(var Idx:int=0; Idx<SymbolCount; Idx++)
//			{
//				var Index:int = Model.readByte();
//				var Pack:String = Model.readUTFBytes(50);
//				var cls:String = Model.readUTFBytes(50);
//				Component.Symbol[Index] = Pack + cls;
//			}
			
			//Component.Control = Control;
			Component.Category = Category;
			Component.Version = Version;
			
			//var Control:UIControl = ReadControl(Model);
			
//			var Type:int = Model.readByte();
//			//var Id:String = Model.readUTFBytes(20);
//			
//			//1	Short	控件类型
//			switch(Type)
//			{
//				case ControlType.SIMPLEBUTTON:
//					Control = new UIButton();
//					break;
//				case ControlType.SIMPLEPANEL:
//					Control = new UIPanel();
//					break;
////				case ControlType.HORIZONTALPANEL:
////					Control = new HorizontalPanel();
////					break;
////				case ControlType.VERTICALPANEL:
////					Control = new VerticalPanel();
////				case ControlType.SLIDER:
//					Control = new UISlider();
//					break;
//				case ControlType.LABEL:
//					Control = new UILabel();
//					break;
//				case ControlType.TEXTINPUT:
//					Control = new UITextInput();
//					break;
//				case ControlType.IMAGE:
//					Control = new UIImage();
//					break;
////				case ControlType.CUSTOMER:
////					//自定义组件类型,查找当前加载的自定义组件库,匹配自定义组件
////					var CustomPack:String = StringUtil.trim(Model.readUTFBytes(50));
////					var CustomClass:String = StringUtil.trim(Model.readUTFBytes(50));
////					
////					var CustomComponent:ComponentModel = this.FindModelByFullName(CustomPack,CustomClass);
////					if(CustomComponent)
////					{
////						CustomComponent = Decode(this.ModelCopy(CustomComponent.ModelByte));
////						if(CustomComponent)
////						{
////							Control = CustomComponent.Control;
////						}
////					}
////					break;
//			}
//			if(Control)
//			{
//				Control.Decode(Model);
//			}
			
			Component.Control = ReadControl(Model,Type);
		}
		catch(Err:Error)
		{
			trace(Err.message);
			throw Err;
		}
		return Component;
	}
}