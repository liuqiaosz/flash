package text
{
	import flash.text.engine.TextLine;

	public class RichTextFactory
	{
		private static var _instance:IRichTextFactory = null;
		public function RichTextFactory()
		{
		}
		
		public static function get instance():IRichTextFactory
		{
			if(!_instance)
			{
				_instance = new RichTextFactoryImpl();
			}
			return _instance;
		}
	}
}

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import flash.text.TextInteractionMode;
import flash.text.engine.ContentElement;
import flash.text.engine.ElementFormat;
import flash.text.engine.FontDescription;
import flash.text.engine.GraphicElement;
import flash.text.engine.GroupElement;
import flash.text.engine.RenderingMode;
import flash.text.engine.TextBaseline;
import flash.text.engine.TextBlock;
import flash.text.engine.TextElement;
import flash.text.engine.TextLine;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import text.IRichTextFactory;

class RichTextFactoryImpl implements IRichTextFactory
{
	private var _iconCacne:Dictionary = null;
	private var reg:RegExp = /\[\w+\]/g;
	
	public function RichTextFactoryImpl()
	{
		_iconCacne = new Dictionary();
	}
	
	/**
	 * 文本解析
	 **/
	public function parse(value:String,width:int,fontFormat:ElementFormat = null):Vector.<TextLine>
	{
		var textFormat:ElementFormat = fontFormat;
		if(!textFormat)
		{
			var desc:FontDescription = new FontDescription();
			desc.renderingMode = RenderingMode.CFF;
			//默认文字格式
			textFormat = new ElementFormat(desc);
			textFormat.dominantBaseline = TextBaseline.IDEOGRAPHIC_TOP;
			textFormat.alignmentBaseline = TextBaseline.DESCENT;
		}
		
		var elements:Vector.<ContentElement> = new Vector.<ContentElement>();
		var icons:Array = value.match(reg);
		var texts:Array = value.split(reg);
		var dispatcher:EventDispatcher = new EventDispatcher();
		dispatcher.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
			
			var line:TextLine = event.currentTarget as TextLine;
			var idx:int = line.getAtomIndexAtPoint(event.stageX,event.stageY);
		
			//var atom:DisplayObject = line.getChildAt(idx);
			
			trace(line.atomCount);
			
			//trace(atom);
		});
		if(icons && icons.length > 0)
		{
			var textValue:String = value;
			var id:String = "";
			var icon:Bitmap = null;
			var image:GraphicElement = null;
			var offset:int = 0;
			var subtext:String = "";
			var iconFormat:ElementFormat = new ElementFormat();
			iconFormat.dominantBaseline = TextBaseline.IDEOGRAPHIC_TOP;
			iconFormat.alignmentBaseline = TextBaseline.DESCENT;
			var txtElement:TextElement = null;
			for each(id in icons)
			{
				offset = textValue.indexOf(id);
				if(offset > 0)
				{
					//icon前面还有文字
					subtext = textValue.substring(0,offset);
					//创建前面的文字元素
					txtElement = new TextElement(subtext,textFormat,dispatcher);
					txtElement.userData = subtext;
					elements.push(txtElement);
					textValue = textValue.substr(offset + id.length);
				}
				if(id in _iconCacne)
				{
					icon = _iconCacne[id] as Bitmap;
					image = new GraphicElement(new Bitmap(icon.bitmapData),icon.width,icon.height,iconFormat,dispatcher);
					elements.push(image);
				}
			}
			txtElement = new TextElement(textValue,textFormat,dispatcher);
			txtElement.userData = textValue;
			elements.push(txtElement);
		}
		else
		{
			txtElement = new TextElement(value,textFormat,dispatcher);
			txtElement.userData = value;
			elements.push(txtElement);
		}
		
		var lines:Vector.<TextLine> = new Vector.<TextLine>();
		var block:TextBlock = new TextBlock();
		block.content = new GroupElement(elements);
		var line:TextLine = block.createTextLine(null,width);
		while(line)
		{
			lines.push(line);
			line = block.createTextLine(line,width);
		}
		return lines;
	}
	
	public function addIcon(key:String,icon:Bitmap):void
	{
		_iconCacne[key] = icon
	}
	
}