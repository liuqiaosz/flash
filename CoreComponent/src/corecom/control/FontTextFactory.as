package corecom.control
{
	

	public class FontTextFactory
	{
		private static var _Instance:IFontTextFactory = null;
		public function FontTextFactory()
		{
		}
		
		public static function get Instance():IFontTextFactory
		{
			if(null == _Instance)
			{
				_Instance = new FontTextFactoryImpl();
			}
			return _Instance;
		}
	}
}

import corecom.control.IFontTextFactory;
import corecom.control.style.FontStyle;

import flash.text.engine.BreakOpportunity;
import flash.text.engine.ElementFormat;
import flash.text.engine.LineJustification;
import flash.text.engine.SpaceJustifier;
import flash.text.engine.TextBaseline;
import flash.text.engine.TextBlock;
import flash.text.engine.TextElement;
import flash.text.engine.TextLine;
import flash.utils.Dictionary;

class FontTextFactoryImpl implements IFontTextFactory
{
	public function Text(Value:String,FontSize:int = 12):TextLine
	{
		var Format:ElementFormat = new ElementFormat();
		Format.fontSize = FontSize;
		//Format. = TextBaseline.ASCENT;
		var Element:TextElement = new TextElement(Value,Format);
		
		var Block:TextBlock = new TextBlock(Element);
		
		return Block.createTextLine(null);
	}
	
	public function TextByStyle(Value:String,Style:FontStyle,Width:int = 1000000):TextLine
	{
		var Format:ElementFormat = new ElementFormat();
		Format.fontSize = Style.FontSize;
		Format.color = Style.FontColor;
		//Format. = TextBaseline.ASCENT;
		var Element:TextElement = new TextElement(Value,Format);
		
		var Block:TextBlock = new TextBlock(Element);
		
		return Block.createTextLine(null,Width <= 0 ? 100:Width);
	}
}