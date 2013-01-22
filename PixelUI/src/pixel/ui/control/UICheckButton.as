package pixel.ui.control
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UICheckButtonStyle;
	import pixel.ui.core.PixelUINS;

	use namespace PixelUINS;
	
	/**
	 * 复选框
	 **/
	public class UICheckButton extends UIControl
	{
		private var _lineGap:int = 1;
		private var _selected:Boolean = false;
		public function get selected():Boolean
		{
			return _selected;
		}
		
		override public function initializer():void
		{
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function UICheckButton(style:Class = null)
		{
			super(style ? style:UICheckButtonStyle);
		}
		
		private function onClick(event:MouseEvent):void
		{
			_selected = !_selected;
			this.StyleUpdate();
		}
		
		/**
		 * 自定义渲染
		 **/
		override protected function StyleRender(style:IVisualStyle):void
		{
			var draw:Graphics = this.graphics;
			if(style.BorderThinkness > 0)
			{
				draw.lineStyle(style.BorderThinkness,style.BorderColor,style.BorderAlpha);
				draw.drawRect(0,0,width,height);
			}
			draw.lineStyle(0);
			var fillW:int = width - (style.BorderThinkness * 2) - (_lineGap * 2);
			var fillH:int = height - (style.BorderThinkness * 2) - (_lineGap * 2);
			var pos:int = style.BorderThinkness + _lineGap;
			if(_selected)
			{
				draw.beginFill(style.BackgroundColor,style.BackgroundAlpha);
			}
			else
			{
				draw.beginFill(0xFFFFFF);
			}
			draw.drawRect(pos,pos,fillW,fillH);
			draw.endFill();
		}
		
		override public function dispose():void
		{
			removeEventListener(MouseEvent.CLICK,onClick);
		}
	}
}