package editor.code
{
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UISlider;
	import pixel.ui.control.SimpleTabPanel;
	import pixel.ui.control.Tab;
	import pixel.ui.control.TabContent;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.style.ContainerStyle;
	import corecom.control.style.IStyle;
	import corecom.control.style.IVisualStyle;
	import pixel.ui.control.style.ButtonStyle;
	import pixel.ui.control.style.SliderStyle;
	import pixel.ui.control.style.UIStyle;
	import pixel.ui.control.utility.ButtonState;
	
	import editor.model.ComponentModel;
	import editor.model.ModelFactory;
	import editor.ui.ComponentProfile;
	import editor.ui.Shell;
	import editor.utils.Common;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.*;
	
	import mx.controls.sliderClasses.Slider;
	import mx.graphics.codec.PNGEncoder;
	import mx.utils.StringUtil;

	/**
	 * 组建代码输出类
	 **/
	public class ComponentClass
	{
//		public static const PACKAGE:String = "package {PackageName}\n{\n import " + Common.CORECOMPACK + ";\n import flash.display.Bitmap; \n";
//		public static const CLASS:String = "public class {ClassName} extends {SuperClassName}\n{\n {Embed}";
//		public static const CONSTRUCT:String = "public function {ClassName}():void\n{\n super();\n {ConstructContent}\n}\n";
//		public static const END:String = "}\n";
		
		public static const TEMPLATE:String = "package {Package}\n{\nimport " + Common.CORECOMPACK + "\n import flash.display.Bitmap;\nimport flash.display.BitmapData; \nimport corecom.control.style.*; \npublic class {ClassName} extends {SuperClass}\n{\n{Var}\npublic function {ClassName}()\n{\n{Initialize}\n{StyleCode}\n}\n}\n}\n";
		
		private var _Control:UIControl = null;
		private var _Component:ComponentProfile = null;
		private var _ChildrenTotal:Array = null;
		public function ComponentClass(ControlShell:Shell,ComProfile:ComponentProfile,Children:Array = null)
		{
			_Control = ControlShell.Control as UIControl;
			_Component = ComProfile;
			_ChildrenTotal = Children;
		}
		
		//元数据标签代码
		private var EmbedCode:String = "";
		
		private var StyleCode:String = "";
		
		private var VarCode:String = "";
		
		private var Initialize:String = "";
		
		private var _ChildCount:int = 0;
		public function Encode():String
		{
			if(_Control)
			{
				var Code:String = TEMPLATE;
				
				//获取控件的全路径名称
				var FullNav:String = getQualifiedClassName(_Control);
				var PackageNav:String = FullNav.substr(0,FullNav.indexOf("::"));
				FullNav = FullNav.replace("::",".");
				
				Code = Code.replace("{Package}",_Component.PackageName);
				Code = Code.replace("{ClassName}",_Component.ClassName);
				Code = Code.replace("{ClassName}",_Component.ClassName);
				Code = Code.replace("{SuperClass}",FullNav);
				GenerateAsset(_Control,"this");
				if(_Component.Category == 1)
				{

					InitializeVars(_ChildrenTotal);
				}
				
				//Code = Code.replace("{Embed}",EmbedCode);
				Code = Code.replace("{Initialize}",Initialize);
				Code = Code.replace("{StyleCode}",StyleCode);
				Code = Code.replace("{Var}",VarCode);
				
				return Code;
			}
			return "";
		}
		
		private function InitializeVars(Children:Array,ParentId:String = ""):void
		{
			var Parent:String = ParentId;
			if(Parent != "")
			{
				Parent += ".";
			}
			
			//var ControlShell:Shell = null;
			var Control:UIControl = null;
			var PosX:int = 0;
			var PosY:int = 0;
			var InstanceName:String = "";
			for(var Idx:int=0; Idx<Children.length; Idx++)
			{
				if(Children[Idx] is UIControl)
				{
					PosX = UIControl(Children[Idx]).x;
					PosY = UIControl(Children[Idx]).y;
					Control = Children[Idx] as UIControl;
				}
				else if(Children[Idx] is Shell)
				{
					PosX = Shell(Children[Idx]).x;
					PosY = Shell(Children[Idx]).y;
					Control = Shell(Children[Idx]).Control as UIControl;
					
					if(Shell(Children[Idx]).IsComponent)
					{
						var Component:ComponentModel = Shell(Children[Idx]).Component;
						GenerateComponent(Component,Shell(Children[Idx]));
						continue;
//						VarCode += "private var " + InstanceName + ":" + Component.PackageName + "." + Component.ClassName + " = new " + Component.PackageName + "." + Component.ClassName + "();\n";
//						Initialize += Parent + "addChild(" + InstanceName + ");\n";
//						Initialize += InstanceName + ".x = " + PosX + ";\n";
//						Initialize += InstanceName + ".y = " + PosY + ";\n";
//						continue;
						//先进行底层控件的样式对比
					}
				}
				InstanceName = GenerateAsset(Control,Control.Id);
				//Content += GenerateCodeByUIControl(ControlShell,InstanceName,AssetsSimpleName);
				Initialize += Parent + "addChild(" + InstanceName + ");\n";
				Initialize += InstanceName + ".x = " + PosX + ";\n";
				Initialize += InstanceName + ".y = " + PosY + ";\n";
				var ChildClassName:String = getQualifiedClassName(Control);
				ChildClassName = ChildClassName.substr((ChildClassName.lastIndexOf(":") + 1));
				VarCode += "public var " + InstanceName + ":" + ChildClassName + " = new " + ChildClassName + "();\n";
				
				//如果为容器对象则继续对子对象进行对象初始化处理
				if(Control is UIContainer)
				{
					InitializeVars(UIContainer(Control).Children,InstanceName);
				}
			}
		}
		
		/**
		 * 检查样式定义是否需要加载图形导入标签
		 **/
//		private function GenerateEmbedCode(Style:IStyle):void
//		{
//			var AssetName:String = "";
//			var AssetSimpleName:String = "";
//			if(Style.BackgroundImage != null)
//			{
//				//将图片数据写入assets目录
//				AssetName = GenerateBitmapAssets(Style.BackgroundImage);
//				AssetSimpleName = AssetName.substr(0,AssetName.indexOf("."));
//				EmbedCode += "[Embed(source=\"assets/" + AssetName + "\")]\n";
//				EmbedCode += "private var " + AssetName.substr(0,AssetName.indexOf(".")) + ":Class;\n";
//				//创建Embed标签对象
//			}
//			
//			/**
//			 * 如果样式为按钮样式则要对不同状态的样式进行处理
//			 **/
//			if(Style is SimpleButtonSkin)
//			{
//				GenerateEmbedCode(SimpleButtonSkin(Style).OverStyle);
//				GenerateEmbedCode(SimpleButtonSkin(Style).PressStyle);
//			}
//		}
		
		private function GenerateComponent(Component:ComponentModel,ComponentShell:Shell):void
		{
			var InstanceName:String = "Component_" + _ChildCount;
			VarCode += "public var " + InstanceName + ":" + Component.PackageName + "." + Component.ClassName + " = new " + Component.PackageName + "." + Component.ClassName + "();\n";
			Initialize += "addChild(" + InstanceName + ");\n";
			Initialize += InstanceName + ".x = " + ComponentShell.x + ";\n";
			Initialize += InstanceName + ".y = " + ComponentShell.y + ";\n";

			//获取原始组件的模型
			var OrignalComponent:ComponentModel = ModelFactory.Instance.FindModelByFullName(Component.PackageName,Component.ClassName);
			//样式对比
			CompareStyle(OrignalComponent.Control.Style,UIControl(ComponentShell.Control).Style,InstanceName);
			
			if(Component.Category == 1)
			{
				var Child:UIControl = null;
				var OrignalChild:UIControl = null;
				var ChildrenLen:int = Component.Children.length;
				for(var Idx:int=0; Idx<ChildrenLen; Idx++)
				{
					Child = Component.Children[Idx];
					OrignalChild = OrignalComponent.Children[Idx];
					CompareStyle(OrignalChild.Style,Child.Style,InstanceName + "." + Child.Id);
					if(Child is SimpleTabPanel)
					{
						if(SimpleTabPanel(Child).Tabs.length > 0)
						{
							var TabLen:int = SimpleTabPanel(Child).Tabs.length;
							StyleCode += "var ComponentTab:corecom.control.Tab = null;\n";
							StyleCode += "var ComponentContent:corecom.control.TabContent = null;\n";
							for(var TabIdx:int=0; TabIdx<TabLen; TabIdx++)
							{
								StyleCode += "ComponentTab = " + InstanceName + "." + Child.Id + ".GetTabAtIndex(" + TabIdx + ");\n";
								StyleCode += "ComponentContent = " + InstanceName + "." + Child.Id + ".FindContentByTab(ComponentTab);\n";
								var TabItem:Tab = SimpleTabPanel(Child).Tabs[TabIdx];
								var TabContentItem:TabContent = SimpleTabPanel(Child).FindContentByTab(TabItem);
								var OrignalTab:Tab = SimpleTabPanel(OrignalChild).Tabs[TabIdx];
								var OrignalContent:TabContent = SimpleTabPanel(OrignalChild).FindContentByTab(OrignalTab);
									
								CompareStyle(OrignalTab.Style,TabItem.Style,"ComponentTab");
								CompareStyle(OrignalContent.Style,TabContentItem.Style,"ComponentContent");
							}
						}
					}
				}
			}
		}
		
		/**
		 * 检查样式定义是否需要加载图形导入标签
		 **/
		private function GenerateAsset(Control:UIControl,InstanceId:String = null,InstanceType:uint = 0):String
		{
			var AssetName:String = "";
			var AssetSimpleName:String = "";
			var Instance:String = InstanceId;
			
			//ControlShell = _Children[Idx];
			if(Instance == "" || Instance == null)
			{
				Instance = "Child_" + _ChildCount;
				Control.Id = Instance;
				_ChildCount++;
				//Control.Id = InstanceName;
			}
			
			if(Control.Style.BackgroundImage != null)
			{
				//将图片数据写入assets目录
//				AssetName = GenerateBitmapAssets(Style.BackgroundImage);
//				AssetSimpleName = AssetName.substr(0,AssetName.indexOf("."));
//				EmbedCode += "[Embed(source=\"assets/" + AssetName + "\")]\n";
//				EmbedCode += "private var " + AssetName.substr(0,AssetName.indexOf(".")) + ":Class;\n";
				//创建Embed标签对象
				//AssetSimpleName = Style.BackgroundImageId;
			}
			
			//如果控件为按钮类型先对其状态进行重置
			if(Control is UIButton)
			{
				UIButton(Control).State = ButtonState.NORMAL;
			}
			GenerateStyle(Control.Style,Instance,InstanceType);
			
			var InsName:String = Instance;
			/**
			 * 如果样式为按钮样式则要对不同状态的样式进行处理
			 **/
			if(Control is UIButton)
			{
				InsName = Instance == "" || Instance == null ? "" : Instance + ".";
				GenerateStyle(ButtonStyle(Control.Style).OverStyle,InsName + "MouseOverStyle",1);
				GenerateStyle(ButtonStyle(Control.Style).PressStyle,InsName + "MouseDownStyle",1);
			}
			else if(Control is SimpleTabPanel)
			{
				InsName = Instance == "" || Instance == null ? "" : Instance + ".";
				if(SimpleTabPanel(Control).Tabs.length > 0)
				{
					StyleCode += "var tab:corecom.control.Tab = null;\n";
					StyleCode += "var content:corecom.control.TabContent = null;\n";
					var Children:Array = SimpleTabPanel(Control).Tabs;
					for(var Idx:int=0; Idx<Children.length; Idx++)
					{
						StyleCode += "tab = " + InsName + "CreateTab();\n";
						StyleCode += "content = " + InsName + "FindContentByTab(tab);";
						GenerateAsset(Children[Idx],"tab");
						GenerateAsset(SimpleTabPanel(Control).FindContentByTab(Children[Idx]),"content");
					}
					StyleCode += InsName + "TabHeight = " + SimpleTabPanel(Control).TabHeight + ";\n";
				}
			}
			return Instance;
//			else if(Control is Container)
//			{
//				InsName = Instance == "" || Instance == null ? "" : Instance + ".";
//				var ChildArray:Array = Container(Control).Children;
//				var Child:UIControl = null;
//				for(var ChildIdx:int=0; ChildIdx<ChildArray.length; ChildIdx++)
//				{
//					Child = ChildArray[ChildIdx] as UIControl;
//					GenerateAsset(Child,Instance);
//				}
//			}
		}
		
		/**
		 * 样式对比
		 **/
		private function CompareStyle(OrignalStyle:IVisualStyle,CurrentStyle:IVisualStyle,InstanceName:String):void
		{
			if(OrignalStyle.BackgroundColor != CurrentStyle.BackgroundColor)
			{
				StyleCode += InstanceName + "." + "BackgroundAlpha=" + CurrentStyle.BackgroundAlpha + ";\n";
			}
			
			if(OrignalStyle.BackgroundColor != CurrentStyle.BackgroundColor)
			{
				StyleCode += InstanceName + "." + "BackgroundColor=" + CurrentStyle.BackgroundColor + ";\n";
			}
			
			if(OrignalStyle.BackgroundImageId != CurrentStyle.BackgroundImageId )
			{
				StyleCode += InstanceName + "." + "BackgroundImage = ControlAssetManager.Instance.FindBitmapById(\"" + CurrentStyle.BackgroundImageId + "\");\n";
			}
			if(OrignalStyle.BorderColor != CurrentStyle.BorderColor)
			{
				StyleCode += InstanceName + "." + "BorderColor=" + CurrentStyle.BorderColor + ";\n";
			}
			if(OrignalStyle.BorderAlpha != CurrentStyle.BorderAlpha)
			{
				StyleCode += InstanceName + "." + "BorderAlpha=" + CurrentStyle.BorderAlpha + ";\n";
			}
			if(OrignalStyle.LeftBottomCorner != CurrentStyle.LeftBottomCorner)
			{
				StyleCode += InstanceName + "." + "LeftBottomCorner=" + CurrentStyle.LeftBottomCorner + ";\n";
			}
			if(OrignalStyle.LeftTopCorner != CurrentStyle.LeftTopCorner)
			{
				StyleCode += InstanceName + "." + "LeftTopCorner=" + CurrentStyle.LeftTopCorner + ";\n";
			}
			if(OrignalStyle.RightTopCorner != CurrentStyle.RightTopCorner)
			{
				StyleCode += InstanceName + "." + "RightTopCorner=" + CurrentStyle.RightTopCorner + ";\n";
			}
			if(OrignalStyle.RightBottomCorner != CurrentStyle.RightBottomCorner)
			{
				StyleCode += InstanceName + "." + "RightBottomCorner=" + CurrentStyle.RightBottomCorner + ";\n";
			}
			if(OrignalStyle.BorderThinkness != CurrentStyle.BorderThinkness)
			{
				StyleCode += InstanceName + "." + "BorderThinkness=" + CurrentStyle.BorderThinkness + ";\n";
			}
			if(OrignalStyle.Radius != CurrentStyle.Radius)
			{
				StyleCode += InstanceName + "." + "Radius=" + CurrentStyle.Radius + ";\n";
			}
			if(OrignalStyle.Shape != CurrentStyle.Shape)
			{
				StyleCode += InstanceName + "." + "Shape=" + CurrentStyle.Shape + ";\n";
			}
			
			if(CurrentStyle is SliderStyle)
			{
				if(SliderStyle(OrignalStyle).SliderLineColor != SliderStyle(CurrentStyle).SliderLineColor)
				{
					StyleCode += InstanceName + "." + "SliderLineColor=" + SliderStyle(CurrentStyle).SliderLineColor + ";\n";
				}
				if(SliderStyle(OrignalStyle).SliderLineHeight != SliderStyle(CurrentStyle).SliderLineHeight)
				{
					StyleCode += InstanceName + "." + "SliderLineHeight=" + SliderStyle(CurrentStyle).SliderLineHeight + ";\n";
				}
			}
		}
		
		//private function GenerateStyle(Style:IStyle,Instance:String = null,InstanceType:uint = 0):void
		private function GenerateStyle(Style:IVisualStyle,Instance:String = null,InstanceType:uint = 0):void
		{
			var Default:UIStyle = new ContainerStyle();
			var InstanceName:String = (Instance != null&& Instance != "") ? Instance + "":"";
			if(InstanceType == 0)
			{
				StyleCode += InstanceName + "." + "width=" + Style.Width + ";\n";
				StyleCode += InstanceName + "." + "height=" + Style.Height + ";\n";
				InstanceName += ".Style";
			}
			else if(InstanceType == 1)
			{
				StyleCode += InstanceName + "." + "Width=" + Style.Width + ";\n";
				StyleCode += InstanceName + "." + "Height=" + Style.Height + ";\n";
			}
			if(Default.BackgroundAlpha != Style.BackgroundAlpha)
			{
				StyleCode += InstanceName + "." + "BackgroundAlpha=" + Style.BackgroundAlpha + ";\n";
			}
			if(Default.BackgroundColor != Style.BackgroundColor)
			{
				StyleCode += InstanceName + "." + "BackgroundColor=" + Style.BackgroundColor + ";\n";
			}
			if(Default.BorderColor != Style.BorderColor)
			{
				StyleCode += InstanceName + "." + "BorderColor=" + Style.BorderColor + ";\n";
			}
			if(Default.BorderAlpha != Style.BorderAlpha)
			{
				StyleCode += InstanceName + "." + "BorderAlpha=" + Style.BorderAlpha + ";\n";
			}
			if(Default.LeftBottomCorner != Style.LeftBottomCorner)
			{
				StyleCode += InstanceName + "." + "LeftBottomCorner=" + Style.LeftBottomCorner + ";\n";
			}
			if(Default.LeftTopCorner != Style.LeftTopCorner)
			{
				StyleCode += InstanceName + "." + "LeftTopCorner=" + Style.LeftTopCorner + ";\n";
			}
			if(Default.RightTopCorner != Style.RightTopCorner)
			{
				StyleCode += InstanceName + "." + "RightTopCorner=" + Style.RightTopCorner + ";\n";
			}
			if(Default.RightBottomCorner != Style.RightBottomCorner)
			{
				StyleCode += InstanceName + "." + "RightBottomCorner=" + Style.RightBottomCorner + ";\n";
			}
			if(Default.BorderThinkness != Style.BorderThinkness)
			{
				StyleCode += InstanceName + "." + "BorderThinkness=" + Style.BorderThinkness + ";\n";
			}
			if(Default.Radius != Style.Radius)
			{
				StyleCode += InstanceName + "." + "Radius=" + Style.Radius + ";\n";
			}
			if(Default.Shape != Style.Shape)
			{
				StyleCode += InstanceName + "." + "Shape=" + Style.Shape + ";\n";
			}
			if(Style.BackgroundImageId != null && "" != Style.BackgroundImageId)
			{
				//StyleCode += InstanceName + "BackgroundImage = new " + BackgroundImg + "() as Bitmap;\n";
				StyleCode += InstanceName + "." + "BackgroundImage = new Bitmap(ControlAssetManager.Instance.FindAssetById(\"" + Style.BackgroundImageId + "\") as BitmapData);\n";
			}
			
			if(Style is SliderStyle)
			{
				var SlideStyle:SliderStyle = new SliderStyle();
				if(SliderStyle(SlideStyle).SliderLineHeight != SliderStyle(Style).SliderLineHeight)
				{
					StyleCode += "SimpleSliderStyle(" + InstanceName + ")." + "SliderLineHeight = " + SliderStyle(Style).SliderLineHeight + ";\n";
				}
				if(SliderStyle(SlideStyle).SliderLineColor != SliderStyle(Style).SliderLineColor)
				{
					StyleCode += "SimpleSliderStyle(" + InstanceName + ")." + "SliderLineColor = " + SliderStyle(Style).SliderLineColor + ";\n";
				}
			}
			
			if(Style.Scale9Grid)
			{
				StyleCode += InstanceName + "." + "Scale9Grid = true;\n";
				StyleCode += InstanceName + "." + "Scale9GridLeft=" + Style.Scale9GridLeft + ";\n";
				StyleCode += InstanceName + "." + "Scale9GridTop=" + Style.Scale9GridTop + ";\n";
				StyleCode += InstanceName + "." + "Scale9GridRight=" + Style.Scale9GridRight + ";\n";
				StyleCode += InstanceName + "." + "Scale9GridBottom=" + Style.Scale9GridBottom + ";\n";
			}
			
			if(Style is ContainerStyle)
			{
				if(ContainerStyle(Default).Gap != ContainerStyle(Style).Gap)
				{
					StyleCode += "ContainerStyle(" + InstanceName + ")." + "Gap = " + ContainerStyle(Style).Gap + ";\n";
				}
				if(ContainerStyle(Default).Layout != ContainerStyle(Style).Layout)
				{
					StyleCode += "ContainerStyle(" + InstanceName + ")." + "Layout = " + ContainerStyle(Style).Layout + ";\n";
				}
				
			}
		}
		
//		private function GenerateBitmapAssets(Image:Bitmap,AssetsName:String = null,Expression:String = "png"):String
//		{
//			var ImgName:String = AssetsName;
//			if(StringUtil.isWhitespace(ImgName) || null == ImgName)
//			{
//				ImgName = "Image_" + Math.floor((Math.random() * 1000 + Math.random() * 1000)) + "." + Expression;
//			}
//			
//			var Encoder:PNGEncoder = new PNGEncoder();
//			//将图片数据写入assets目录
//			var ImgData:BitmapData = Image.bitmapData;
//			var ImgBytes:ByteArray = Encoder.encode(ImgData);
//			ImgBytes.position = 0;
//			var Writer:FileStream = new FileStream();
//			Writer.open(new File(Common.ASSETS + ImgName),FileMode.WRITE);
//			Writer.writeBytes(ImgBytes,0,ImgBytes.bytesAvailable);
//			Writer.close();
//			
//			return ImgName;
//		}
	}
}