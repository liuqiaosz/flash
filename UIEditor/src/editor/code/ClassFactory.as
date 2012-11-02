package editor.code
{
	import corecom.control.Container;
	import corecom.control.UIControl;
	import corecom.control.style.IStyle;
	import corecom.control.style.ButtonStyle;
	
	import editor.ui.Shell;
	import editor.utils.Common;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.*;
	
	import mx.graphics.codec.PNGEncoder;
	import mx.utils.StringUtil;
	
	import utility.System;
	
	public class ClassFactory
	{
		public static const PACKAGE:String = "package {PackageName}\n{\n import " + Common.CORECOMPACK + ";\n import flash.display.Bitmap; \n";
		public static const CLASS:String = "public class {ClassName} extends {SuperClassName}\n{\n {Embed}";
		public static const CONSTRUCT:String = "public function {ClassName}():void\n{\n super();\n {ConstructContent}\n}\n";
		public static const END:String = "}\n";
		
		public function ClassFactory()
		{
			
		}
		
		/**
		 * 
		 **/
		public static function GenerateClassByUIControl(ControlShell:Shell,Package:String,ClassName:String):String
		{
			//CheckPackageNav(Package);
			var Control:UIControl = ControlShell.Control as UIControl;
			
			//获取控件的全路径名称
			var FullNav:String = getQualifiedClassName(Control);
			var PackageNav:String = FullNav.substr(0,FullNav.indexOf("::"));
			FullNav = FullNav.replace("::",".");
			
			var ClassCode:String = PACKAGE.replace("{PackageName}",Package);
			var Class:String = CLASS;
			Class = Class.replace("{ClassName}",ClassName);
			Class = Class.replace("{SuperClassName}",FullNav);
			
			var EmbedCode:String = "";
			var AssetsSimpleName:String = "";
			//检查是否有背景图片引用
			if(Control.Style.BackgroundImage != null)
			{
				//将图片数据写入assets目录
				var AssetsName:String = GenerateBitmapAssets(Control.Style.BackgroundImage);
				AssetsSimpleName = AssetsName.substr(0,AssetsName.indexOf("."));
				EmbedCode += "[Embed(source=\"assets/" + AssetsName + "\")]\n";
				EmbedCode += "private var " + AssetsName.substr(0,AssetsName.indexOf(".")) + ":Class;\n";
				//创建Embed标签对象
			}
			Class = Class.replace("{Embed}",EmbedCode);
			ClassCode += Class;
			var Contruct:String = CONSTRUCT;
			Contruct = Contruct.replace("{ClassName}",ClassName);
			ClassCode += Contruct.replace("{ConstructContent}\n",GenerateCodeByGlobalStyle(Control.Style));
			ClassCode += END;
			ClassCode += END;
			return ClassCode;
		}
		
		/**
		 * 复合组件代码生成
		 **/
		public static function GenerateClassByComplexUIControl(ControlContainer:Shell,Children:Array,Package:String,ClassName:String):String
		{
			var Container:UIControl = ControlContainer.Control as UIControl;
			//CheckPackageNav(Package);
			var ClassCode:String = "";
			//获取控件的全路径名称
			var FullNav:String = getQualifiedClassName(Container);
			var PackageNav:String = FullNav.substr(0,FullNav.indexOf("::"));
			FullNav = FullNav.replace("::",".");
			ClassCode += PACKAGE.replace("{PackageName}",Package);
			var Class:String = CLASS;
			Class = Class.replace("{ClassName}",ClassName);
			Class = Class.replace("{SuperClassName}",FullNav);
			ClassCode += Class;
			var AssetsSimpleName:String = "";
			var AssetsName:String = "";
			var EmbedCode:String = "";
			//检查是否有背景图片引用
			if(Container.Style.BackgroundImage != null)
			{
				//将图片数据写入assets目录
				AssetsName = GenerateBitmapAssets(Container.Style.BackgroundImage);
				AssetsSimpleName = AssetsName.substr(0,AssetsName.indexOf("."));
				EmbedCode += "[Embed(source=\"assets/" + AssetsName + "\")]\n";
				EmbedCode += "private var " + AssetsName.substr(0,AssetsName.indexOf(".")) + ":Class;\n";
				//创建Embed标签对象
			}
			
			//var Content:String = GenerateCodeByGlobalStyle(ControlContainer.Style);
			var Content:String = GenerateCodeByGlobalStyle(Container.Style,null,AssetsSimpleName);
			var InstanceName:String = "";
			var ControlShell:Shell = null;
			var Control:UIControl = null;
			for(var Idx:int=0; Idx<Children.length; Idx++)
			{
				AssetsName = "";
				ControlShell = Children[Idx];
				Control = ControlShell.Control as UIControl;
				//检查是否有背景图片引用
				if(Control.Style.BackgroundImage != null)
				{
					//将图片数据写入assets目录
					AssetsName = GenerateBitmapAssets(Control.Style.BackgroundImage);
					AssetsSimpleName = AssetsName.substr(0,AssetsName.indexOf("."));
					EmbedCode += "[Embed(source=\"assets/" + AssetsName + "\")]\n";
					EmbedCode += "private var " + AssetsSimpleName + ":Class;\n";
					//创建Embed标签对象
				}
				if(Control.Id == "" && Control.Id == null)
				{
					InstanceName = "Child_" + Idx;
				}
				else
				{
					InstanceName = Control.Id;
				}
				Content += GenerateCodeByUIControl(ControlShell,InstanceName,AssetsSimpleName);
				Content += "addChild(" + InstanceName + ");\n";
				var ChildClassName:String = getQualifiedClassName(ControlShell.Control);
				ChildClassName = ChildClassName.substr((ChildClassName.lastIndexOf(":") + 1));
				ClassCode += "private var " + InstanceName + ":" + ChildClassName + " = new " + ChildClassName + "();\n";
			}
			
			ClassCode = ClassCode.replace("{Embed}",EmbedCode);
			var Contruct:String = CONSTRUCT;
			Contruct = Contruct.replace("{ClassName}",ClassName);
			//var Children:Array = ControlContainer.Children;
			ClassCode += Contruct.replace("{ConstructContent}\n",Content);
			ClassCode += END;
			ClassCode += END;
			return ClassCode;
		}
		
		private static function GenerateCodeByUIControl(ControlShell:Shell,Instance:String = null,BackgroundImg:String = null):String
		{
			var Control:UIControl = ControlShell.Control as UIControl;
			var InstanceName:String = Instance;
			//var FullNav:String = getQualifiedClassName(Control);
			//FullNav = FullNav.replace("::",".");
			var Code:String = "";
			
			if(Control.Id == null && Control.Id == "")
			{
				InstanceName = "Control_" + Math.random() * 100;
			}
			else
			{
				InstanceName = Control.Id;
			}
			
			//X和Y的坐标定位取外壳的坐标定位
			Code += InstanceName + ".x = " + ControlShell.x + ";\n";
			Code += InstanceName + ".y = " + ControlShell.y + ";\n";
			var StyleCode:String = GenerateCodeByGlobalStyle(Control.Style,InstanceName,BackgroundImg);
			Code += StyleCode;
			return Code;
		}
		
		/**
		 * 公共样式代码生成
		 **/
		private static function GenerateCodeByGlobalStyle(Style:IStyle,Instance:String = null,BackgroundImg:String = null):String
		{
			var InstanceName:String = Instance != null ? Instance + ".":"";
			var StyleCode:String = "";
			StyleCode += InstanceName + "width=" + Style.Width + ";\n";
			StyleCode += InstanceName + "height=" + Style.Height + ";\n";
			StyleCode += InstanceName + "Style.BackgroundAlpha=" + Style.BackgroundAlpha + ";\n";
			StyleCode += InstanceName + "Style.BackgroundColor=" + Style.BackgroundColor + ";\n";
			StyleCode += InstanceName + "Style.BorderColor=" + Style.BorderColor + ";\n";
			StyleCode += InstanceName + "Style.BorderAlpha=" + Style.BorderAlpha + ";\n";
			StyleCode += InstanceName + "Style.BorderCorner=" + Style.BorderCorner + ";\n";
			StyleCode += InstanceName + "Style.BorderThinkness=" + Style.BorderThinkness + ";\n";
			StyleCode += InstanceName + "Style.Radius=" + Style.Radius + ";\n";
			StyleCode += InstanceName + "Style.Shape=" + Style.Shape + ";\n";
			
			if(BackgroundImg != null && "" != BackgroundImg)
			{
				StyleCode += InstanceName + "Style.BackgroundImage = new " + BackgroundImg + "() as Bitmap;\n";
			}
//			
//			if(Style is SimpleButtonSkin)
//			{
//				StyleCode += GenerateCodeByGlobalStyle(SimpleButtonSkin(Style).OverStyle,Instance
//			}
			return StyleCode;
		}
		
		/**
		 * 输出资源目录检测
		 **/
		private static function CheckAssetsDirectory():void
		{
			var Assets:File = new File(Common.ASSETS);
			if(!Assets.exists)
			{
				Assets.createDirectory();
			}
		}
		
		private static function GenerateBitmapAssets(Image:Bitmap,AssetsName:String = null,Expression:String = "png"):String
		{
			var ImgName:String = AssetsName;
			if(StringUtil.isWhitespace(ImgName) || null == ImgName)
			{
				ImgName = "Image_" + Math.floor((Math.random() * 1000 + Math.random() * 1000)) + "." + Expression;
			}
			
			var Encoder:PNGEncoder = new PNGEncoder();
			//将图片数据写入assets目录
			var ImgData:BitmapData = Image.bitmapData;
			var ImgBytes:ByteArray = Encoder.encode(ImgData);
			ImgBytes.position = 0;
			var Writer:FileStream = new FileStream();
			Writer.open(new File(Common.ASSETS + ImgName),FileMode.WRITE);
			Writer.writeBytes(ImgBytes,0,ImgBytes.bytesAvailable);
			Writer.close();
			
			return ImgName;
		}
	}
}