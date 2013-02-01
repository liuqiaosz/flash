package bleach.scene.ui
{
	import pixel.ui.control.IUITip;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UILabel;
	
	/**
	 * 技能Tip
	 * 
	 **/
	public class SkillTip extends UIContainer implements IUITip
	{
		private var _title:UILabel = null;
		private var _expend:UILabel = null;
		private var _desc:UILabel = null;
		
		public function SkillTip()
		{
			
		}
		
		public function set tipText(value:String):void
		{
			
		}
	}
}