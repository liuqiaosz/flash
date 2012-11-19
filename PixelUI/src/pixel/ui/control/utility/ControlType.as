package pixel.ui.control.utility
{

	public class ControlType
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
		
		public static const CUSTOMER:uint = 99;			//自定义控件
		
		public function ControlType()
		{
			throw new Error(ErrorConstant.ONLYSINGLTON);
		}
	}
}