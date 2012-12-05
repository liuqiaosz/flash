package pixel.ui.control
{
	import pixel.ui.control.style.IVisualStyle;

	public interface IToolTip
	{
		//给控件绑定ToolTip
		function Bind(Control:UIControl):void;
		//解绑
		function UnBind(Control:UIControl):void;
		//变更皮肤
		function ChangeSkin(Skin:IVisualStyle):void;
		
		function changeTip(tip:IPixelTip):void;
		
		function set LazyTime(Value:int):void;
	}
}