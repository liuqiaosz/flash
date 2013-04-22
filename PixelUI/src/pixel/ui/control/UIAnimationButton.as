package pixel.ui.control
{
	import pixel.ui.control.vo.UIAnimAtlas;

	/**
	 * 带动画效果的按钮
	 * 
	 **/
	public class UIAnimationButton extends UIControl
	{
		//常态动画
		private var _normalAtlas:UIAnimAtlas = null;
		//聚焦动画
		private var _focusAtlas:UIAnimAtlas = null;
		//按下动画
		private var _pressedAtlas:UIAnimAtlas = null;
		
		public function UIAnimationButton()
		{
			super();
		}
	}
}