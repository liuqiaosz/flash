package pixel.ui.control.utility
{
	import pixel.ui.control.SimpleTabPanel;
	import pixel.ui.control.Tab;
	import pixel.ui.control.TabBar;
	import pixel.ui.control.TabContent;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UICombobox;
	import pixel.ui.control.UIComboboxPop;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIImage;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.UISlider;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.UIVerticalPanel;
	import pixel.utility.Tools;

	public class Utils
	{
		public static const SIMPLEBUTTON:uint = 0;		//按钮
		public static const SIMPLEPANEL:uint = 1;		//面板
		public static const HORIZONTALPANEL:uint = 2;	//横向面板
		public static const VERTICALPANEL:uint = 3;		//纵向面板
		public static const GRIDPANEL:uint = 4;			//网格面板
		public static const PROGRESS:uint = 5;			//加载进度条
		public static const TABPANEL:uint = 6;			//TAB面板
		public static const SLIDER:uint = 7;			//拖拉条
		public static const TABBAR:uint = 9;			//标签栏
		public static const TAB:uint = 10;
		public static const TABCONTENT:uint = 11;
		public static const LABEL:int = 12;			//文本
		public static const IMAGE:int = 13;			//图形
		public static const TEXTINPUT:int = 14;		//文本输入
		public static const WINDOW:int = 15;			//窗口
		public static const COMBOBOX:int = 16;		//下拉框
		public static const COMBOBOXPOP:int = 17;		//下拉框弹出面板
		public static const VPANEL:int = 18;
		
		public static const CUSTOMER:uint = 99;			//自定义控件
		
		public function Utils()
		{
			throw new Error(ErrorConstant.ONLYSINGLTON);
		}
		
		/**
		 * 获取控件原型代码
		 **/
		public static function GetControlPrototype(Control:UIControl):uint
		{
			//通过报名判断是否自定义控件类型
//			if(Tools.GetPackage(Control).indexOf("corecom.control") < 0)
//			{
//				return ControlType.CUSTOMER;
//			}
			if(Control is Tab)
			{
				return TAB;
			}
			else if(Control is TabBar)
			{
				return TABBAR;
			}
			else if(Control is TabContent)
			{
				return TABCONTENT;
			}
			else if(Control is SimpleTabPanel)
			{
				return TABPANEL;
			}
			else if(Control is UISlider)
			{
				return SLIDER;
			}
			else if(Control is UIButton)
			{
				return SIMPLEBUTTON;
			}
			else if(Control is UIPanel)
			{
				return SIMPLEPANEL;
			}
			else if(Control is UILabel)
			{
				return LABEL;
			}
			else if(Control is UIImage)
			{
				return IMAGE;
			}
			else if(Control is UITextInput)
			{
				return TEXTINPUT;
			}
			else if(Control is UICombobox)
			{
				return COMBOBOX;
			}
			else if(Control is UIComboboxPop)
			{
				return COMBOBOXPOP;
			}
			else if(Control is UIVerticalPanel)
			{
				return VPANEL;
			}
			else if(Control is UIProgress)
			{
				return PROGRESS;
			}
			return 99;
		}
		
		public static function GetPrototype(Control:UIControl):Class
		{
			if(Control is Tab)
			{
				return Tab;
			}
			else if(Control is TabBar)
			{
				return TabBar;
			}
			else if(Control is TabContent)
			{
				return TabContent;
			}
			else if(Control is SimpleTabPanel)
			{
				return SimpleTabPanel;
			}
			else if(Control is UISlider)
			{
				return UISlider;
			}
			else if(Control is UIButton)
			{
				return UIButton;
			}
			else if(Control is UIPanel)
			{
				return UIPanel;
			}
			else if(Control is UILabel)
			{
				return UILabel;
			}
			else if(Control is UICombobox)
			{
				return UICombobox;
			}
			else if(Control is UIComboboxPop)
			{
				return UIComboboxPop;
			}
			else if(Control is UIVerticalPanel)
			{
				return UIVerticalPanel;
			}
			else if(Control is UIProgress)
			{
				return UIProgress;
			}
			return null;
		}
		
		public static function GetPrototypeByType(Type:uint):Class
		{
			switch(Type)
			{
				case SIMPLEBUTTON:
					return UIButton;
					break;
				case TABPANEL:
					return SimpleTabPanel;
					break;
				case TAB:
					return Tab;
					break;
				case TABBAR:
					return TabBar;
					break;
				case TABCONTENT:
					return TabContent;
					break;
				case SLIDER:
					return UISlider;
					break;
				case SIMPLEPANEL:
					return UIPanel;
					break;
				case LABEL:
					return UILabel;
					break;
				case IMAGE:
					return UIImage;
					break;
				case TEXTINPUT:
					return UITextInput;
					break;
				case COMBOBOX:
					return UICombobox;
					break;
				case COMBOBOXPOP:
					return UIComboboxPop;
					break;
				case VPANEL:
					return UIVerticalPanel;
					break;
				case PROGRESS:
					return UIProgress;
					break;
			}
			return null;
		}
	}
}