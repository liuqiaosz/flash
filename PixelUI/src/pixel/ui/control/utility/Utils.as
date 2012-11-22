package pixel.ui.control.utility
{
	import pixel.ui.control.SimpleTabPanel;
	import pixel.ui.control.Tab;
	import pixel.ui.control.TabBar;
	import pixel.ui.control.TabContent;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIImage;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UISlider;
	import pixel.ui.control.UITextInput;
	
	import pixel.utility.Tools;

	public class Utils
	{
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
			if(Tools.GetPackage(Control).indexOf("corecom.control") < 0)
			{
				return ControlType.CUSTOMER;
			}
			if(Control is Tab)
			{
				return ControlType.TAB;
			}
			else if(Control is TabBar)
			{
				return ControlType.TABBAR;
			}
			else if(Control is TabContent)
			{
				return ControlType.TABCONTENT;
			}
			else if(Control is SimpleTabPanel)
			{
				return ControlType.TABPANEL;
			}
			else if(Control is UISlider)
			{
				return ControlType.SLIDER;
			}
			else if(Control is UIButton)
			{
				return ControlType.SIMPLEBUTTON;
			}
			else if(Control is UIPanel)
			{
				return ControlType.SIMPLEPANEL;
			}
			else if(Control is UILabel)
			{
				return ControlType.LABEL;
			}
			else if(Control is UIImage)
			{
				return ControlType.IMAGE;
			}
			else if(Control is UITextInput)
			{
				return ControlType.TEXTINPUT;
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
			return null;
		}
		
		public static function GetPrototypeByType(Type:uint):Class
		{
			switch(Type)
			{
				case ControlType.SIMPLEBUTTON:
					return UIButton;
					break;
				case ControlType.TABPANEL:
					return SimpleTabPanel;
					break;
				case ControlType.TAB:
					return Tab;
					break;
				case ControlType.TABBAR:
					return TabBar;
					break;
				case ControlType.TABCONTENT:
					return TabContent;
					break;
				case ControlType.SLIDER:
					return UISlider;
					break;
				case ControlType.SIMPLEPANEL:
					return UIPanel;
					break;
				case ControlType.LABEL:
					return UILabel;
					break;
				case ControlType.IMAGE:
					return UIImage;
					break;
				case ControlType.TEXTINPUT:
					return UITextInput;
					break;
			}
			return null;
		}
	}
}