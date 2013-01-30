package
{
	import flash.utils.Dictionary;
	
	import pixel.ui.control.IPixelTip;
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.vo.UIStyleMod;
	
	public class SkillTip  extends UIContainer implements IPixelTip
	{
		private var _title:UILabel = null;
		private var _expend:UILabel = null;
		private var _desc:UILabel = null;
		
		public function SkillTip()
		{
			_title = new UILabel();
			_expend = new UILabel();
			_desc = new UILabel();
			
			_title.height = 20;
			_expend.height = 20;
			_desc.height = 20;
			
			Layout = LayoutConstant.VERTICAL;
			
			width = 200;
			height = 200;
			
			Gap = 2;
			padding = 5;
			
			addChild(_title);
			addChild(_expend);
			addChild(_desc);
			
			BackgroundColor = 0x000000;
			BackgroundAlpha = 0.2;
		}
		override public function set padding(value:int):void
		{
			super.padding = value;
			updateSize();
		}
		override public function set width(value:Number):void
		{
			super.width = value;
			updateSize();
		}
		
		private function updateSize():void
		{
			_desc.width = (width - padding);
		}
		
		public function updateStyle(styles:Vector.<UIStyleMod>):void
		{
			var dict:Dictionary = new Dictionary();
			for each(var style:UIStyleMod in styles)
			{
				dict[style.id] = style.style;
			}
			
			_title.Style = dict["SkillTitle"];
			_expend.Style = dict["SkillExpend"];
			_desc.Style = dict["SkillDesc"];
			_desc.Mutiline = true;
		}
		
		public function set tipText(value:String):void
		{
			_title.text = "生命恢复";
			_expend.text = "消耗: 150体力";
			_desc.text = "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
		}
	}
}