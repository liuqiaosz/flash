package text
{
	import flash.display.Bitmap;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.TextLine;

	public interface IRichTextFactory
	{
		function parse(value:String,width:int,fontFormat:ElementFormat = null):Vector.<TextLine>;
		function addIcon(key:String,icon:Bitmap):void;
	}
}