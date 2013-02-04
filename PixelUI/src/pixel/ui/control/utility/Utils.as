package pixel.ui.control.utility
{
	import pixel.ui.control.*;
	import pixel.ui.control.style.*;
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
		public static const CHECKBOX:int = 19;
		public static const CHECKBOXBTN:int = 20;
		public static const TOGGLE_BUTTON:int = 21;		//状态切换按钮
		public static const RADIO:int = 22				//radio按钮
		
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
//			if(Control is Tab)
//			{
//				return TAB;
//			}
//			else if(Control is TabBar)
//			{
//				return TABBAR;
//			}
//			else if(Control is TabContent)
//			{
//				return TABCONTENT;
//			}
//			else if(Control is SimpleTabPanel)
//			{
//				return TABPANEL;
//			}
			if(Control is UISlider)
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
			else if(Control is UIWindow)
			{
				return WINDOW;
			}
			else if(Control is UICheckBox)
			{
				return CHECKBOX;
			}
			else if(Control is UICheckButton)
			{
				return CHECKBOXBTN;
			}
			else if(Control is UIToggleButton)
			{
				return TOGGLE_BUTTON;
			}
			else if(Control is UIRadio)
			{
				return RADIO;
			}
			return 99;
		}
		
		public static function GetPrototype(Control:UIControl):Class
		{
//			if(Control is Tab)
//			{
//				return Tab;
//			}
//			else if(Control is TabBar)
//			{
//				return TabBar;
//			}
//			else if(Control is TabContent)
//			{
//				return TabContent;
//			}
//			else if(Control is SimpleTabPanel)
//			{
//				return SimpleTabPanel;
//			}
			if(Control is UISlider)
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
			else if(Control is UIWindow)
			{
				return UIWindow;
			}
			else if(Control is UICheckBox)
			{
				return UICheckBox;
			}
			else if(Control is UICheckButton)
			{
				return UICheckButton;
			}
			else if(Control is UIToggleButton)
			{
				return UIToggleButton;
			}
			else if(Control is UIRadio)
			{
				return UIRadio;
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
//				case TABPANEL:
//					return SimpleTabPanel;
//					break;
//				case TAB:
//					return Tab;
//					break;
//				case TABBAR:
//					return TabBar;
//					break;
//				case TABCONTENT:
//					return TabContent;
//					break;
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
				case WINDOW:
					return UIWindow;
					break;
				case CHECKBOX:
					return UICheckBox;
					break;
				case CHECKBOXBTN:
					return UICheckBox;
					break;
				case TOGGLE_BUTTON:
					return UIToggleButton;
					break;
				case RADIO:
					return UIRadio;
					break;
			}
			return null;
			
		}
		
		public static function getStylePrototypeByType(type:int):Class
		{
			switch(type)
			{
				case SIMPLEBUTTON:
					return UIButtonStyle;
					break;
				case TABPANEL:
					return UIPanelStyle;
					break;
//				case TAB:
//					return Tab;
//					break;
//				case TABBAR:
//					return TabBar;
//					break;
//				case TABCONTENT:
//					return TabContent;
//					break;
				case SLIDER:
					return UISliderStyle;
					break;
				case SIMPLEPANEL:
					return UIPanelStyle;
					break;
				case LABEL:
					return UILabelStyle;
					break;
				case IMAGE:
					return UIImageStyle;
					break;
				case TEXTINPUT:
					return UITextInputStyle;
					break;
				case COMBOBOX:
					return UICombStyle;
					break;
				case COMBOBOXPOP:
					return UIComboboxPop;
					break;
				case VPANEL:
					return UIVerticalPanelStyle;
					break;
				case PROGRESS:
					return UIProgressStyle;
					break;
				case WINDOW:
					return UIWindow;
					break;
				case CHECKBOXBTN:
					return UICheckBox;
					break;
				case TOGGLE_BUTTON:
					return UIToggleButtonStyle;
					break;
				case RADIO:
					return UIRadioStyle;
					break;
			}
			return null;
			
		}
		
		public static function getStyleTypeByPrototype(Control:IVisualStyle):int
		{
			
			if(Control is UISliderStyle)
			{
				return SLIDER;
			}
			else if(Control is UIButtonStyle)
			{
				return SIMPLEBUTTON;
			}
			else if(Control is UIPanelStyle)
			{
				return SIMPLEPANEL;
			}
			else if(Control is UILabelStyle)
			{
				return LABEL;
			}
			else if(Control is UIImageStyle)
			{
				return IMAGE;
			}
			else if(Control is UITextInputStyle)
			{
				return TEXTINPUT;
			}
			else if(Control is UICombStyle)
			{
				return COMBOBOX;
			}
			else if(Control is UIComboboxPop)
			{
				return COMBOBOXPOP;
			}
			else if(Control is UIVerticalPanelStyle)
			{
				return VPANEL;
			}
			else if(Control is UIProgressStyle)
			{
				return PROGRESS;
			}
			else if(Control is UIWindow)
			{
				return WINDOW;
			}
			else if(Control is UICheckBox)
			{
				return CHECKBOX;
			}
			else if(Control is UICheckButton)
			{
				return CHECKBOXBTN;
			}
			else if(Control is UIToggleButtonStyle)
			{
				return TOGGLE_BUTTON;
			}
			else if(Control is UIRadioStyle)
			{
				return RADIO;
			}
			return 99;
		}
		
		public static function getStyleNameByType(type:int):String
		{
			switch(type)
			{
				case SIMPLEBUTTON:
					return "Button";
					break;
//				case TABPANEL:
//					return UIPanelStyle;
//					break;
//				case TAB:
//					return Tab;
//					break;
//				case TABBAR:
//					return TabBar;
//					break;
//				case TABCONTENT:
//					return TabContent;
//					break;
				case SLIDER:
					return "Slider";
					break;
				case SIMPLEPANEL:
					return "Panel";
					break;
				case LABEL:
					return "Label";
					break;
				case IMAGE:
					return "Image";
					break;
				case TEXTINPUT:
					return "TextInput";
					break;
				case COMBOBOX:
					return "Combobox";
					break;
//				case COMBOBOXPOP:
//					return UIComboboxPop;
					break;
				case VPANEL:
					return "VScrollPanel";
					break;
				case PROGRESS:
					return "Progress";
					break;
				case WINDOW:
					return "Window";
					break;
				case CHECKBOX:
					return "Checkbox";
					break;
				case CHECKBOXBTN:
					return "CheckBoxButton";
					break;
				case TOGGLE_BUTTON:
					return "ToggleButton";
					break;
				case RADIO:
					return "Radio";
					break;
			}
			return null;
		}
	}
}