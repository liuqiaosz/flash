package pixel.ui.control
{
	import pixel.ui.control.vo.ColorFormat;

	/**
	 * 多彩文本支持
	 * 
	 **/
	public class UIColorfulLabel extends UITextBase
	{
		private var formats:Vector.<ColorFormat> = null;
		public function UIColorfulLabel()
		{
			super();
		}
		
		/**
		 * 文本分析
		 * 
		 **/
		protected function formatAnalysis(value:String):void
		{
			var str:String = "我是红色,我是绿色，我是蓝色";
		}
	}
}
