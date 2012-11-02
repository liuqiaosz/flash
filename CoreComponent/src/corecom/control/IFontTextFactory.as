package corecom.control
{
	import corecom.control.style.FontStyle;
	
	import flash.text.engine.TextLine;

	public interface IFontTextFactory
	{
		function Text(Value:String,FontSize:int = 12):TextLine;
		function TextByStyle(Value:String,Style:FontStyle,Width:int = 1000000):TextLine;
	}
}