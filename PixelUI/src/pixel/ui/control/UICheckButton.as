package pixel.ui.control
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import pixel.ui.control.event.UIControlEvent;
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
		public function set selected(value:Boolean):void
		{
			_selected = value;
			this.Update();
		}
		
		override public function initializer():void
		{
			
		}
		
		public function UICheckButton(style:Class = null)
		{
			super(style ? style:UICheckButtonStyle);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		private function onClick(event:MouseEvent):void
		{
			_selected = !_selected;
			StyleUpdate();
			dispatchEvent(new UIControlEvent(UIControlEvent.CHANGE,true));
		}
		
		/**
		 * 自定义渲染
		 **/
		override protected function StyleRender(style:IVisualStyle):void
		{
			var draw:Graphics = this.graphics;
			draw.clear();
			if(style.BorderThinkness > 0)
			{
				draw.lineStyle(style.BorderThinkness,style.BorderColor,style.BorderAlpha);
			}
			else
			{
				draw.lineStyle(0,0,0);
			}
//			var s:Boolean = Boolean(style.BorderThinkness & 1);
//			var fillW:int = width - (style.BorderThinkness * 2) - (_lineGap * (s ? 1:2));
//			var fillH:int = height - (style.BorderThinkness * 2) - (_lineGap * (s ? 1:2));
//			var fillW:int = width - (style.BorderThinkness * 2);
//			var fillH:int = height - (style.BorderThinkness * 2);
//			var pos:int = style.BorderThinkness * 2 + style.BorderThinkness;
			if(_selected)
			{
				draw.beginFill(style.BackgroundColor,style.BackgroundAlpha);
			}
			else
			{
				draw.beginFill(0xFFFFFF,0.2);
			}
			//draw.drawRect(pos,pos,fillW,fillH);
			draw.drawRect(0,0,width,height);
			draw.endFill();
		}
		
		override public function dispose():void
		{
			removeEventListener(MouseEvent.CLICK,onClick);
		}
	}
}