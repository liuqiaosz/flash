package corecom.control
{
	import corecom.control.event.ComboboxEvent;
	import corecom.control.style.CombStyle;
	
	import flash.events.MouseEvent;
	import flash.text.engine.TextLine;

	/**
	 * 下拉框
	 * 上拉框
	 * 
	 **/
	public class Combobox extends Container
	{
		private var _LabelField:ComboTextField = null;
		private var _Items:Vector.<ComboboxItem> = null;
		private var _List:ComboItemList = new ComboItemList();
		private var _Popup:Boolean = false;
		public function Combobox(Skin:Class = null)
		{
			var StyleSkin:Class = Skin ? Skin:CombStyle;
			super(StyleSkin);
			_LabelField = new ComboTextField();
			width = 100;
			height = 20;
			addChild(_LabelField);
			addChild(_List);
			_List.visible = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN,OnClick);
		}
		
		
		private function OnClick(event:MouseEvent):void
		{
			var Sender:Object = event.target;
			if(Sender is TextLine || Sender is ComboListItem)
			{
				var Item:ComboListItem = Sender is TextLine ? TextLine(Sender).parent as ComboListItem:Sender as ComboListItem;
				if(Item)
				{
					var Notify:ComboboxEvent = new ComboboxEvent(ComboboxEvent.SELECT);
					Notify.Item = Item.Item;
					this.dispatchEvent(Notify);
					
					_LabelField.Text = Item.Item.Label;
				}
				//trace(TextLine(event.target).parent);
			}
			_List.y = (_List.height + 2) * -1;
			_List.visible = !_Popup;
			_Popup = _List.visible;
		}
		
		public function set Items(Value:Vector.<ComboboxItem>):void
		{
			_Items = Value;
			for each(var Item:ComboboxItem in _Items)
			{
				_List.AddItem(Item);
			}
		}
		public function get Items():Vector.<ComboboxItem>
		{
			return _Items;
		}
		
		public function set ItemHeight(Value:int):void
		{
			_List.ItemHeight = Value;	
		}
		
		/**
		 * 设置子选项聚焦的背景色
		 * 
		 * 
		 **/
		public function set ItemFocusColor(Value:uint):void
		{
			_List.ItemFocusColor = Value;
		}
		
		
		override public function Dispose():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,OnClick);
		}
		
		
	}
}
import corecom.control.ComboboxItem;
import corecom.control.Container;
import corecom.control.FontTextFactory;
import corecom.control.LayoutConstant;
import corecom.control.UIControl;
import corecom.control.style.FontStyle;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.engine.TextLine;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import utility.Tools;

class ComboItemList extends Container
{
	private var _Items:Vector.<ComboListItem> = new Vector.<ComboListItem>();
	private var _LastMove:ComboListItem = null;
	private var _FocusColor:uint = 0xFFFFFF;
	
	public function ComboItemList()
	{
		
		super();
		this.Layout = LayoutConstant.VERTICAL;
		this.BorderThinkness = 1;
		width = 150;
		//height = 150;
		this.addEventListener(MouseEvent.MOUSE_OVER,FocusMove);
		this.addEventListener(MouseEvent.MOUSE_OUT,function(event:MouseEvent):void{
			
			Mouse.cursor = MouseCursor.AUTO;
		});
	}
	
	private function FocusMove(event:MouseEvent):void
	{
		Mouse.cursor = MouseCursor.BUTTON;
		if(event.target is ComboListItem)
		{
			if(_LastMove == event.target)
			{
				return;
			}
			if(_LastMove)
			{
				_LastMove.BackgroundColor = 0xFFFFFF;
				_LastMove.BackgroundAlpha = 1;
			}
			
			_LastMove = event.target as ComboListItem;
			_LastMove.BackgroundColor = _FocusColor;
			_LastMove.BackgroundAlpha = 0.6;
		}
	}
	
	
	override public function Dispose():void
	{
		this.removeEventListener(MouseEvent.MOUSE_OVER,FocusMove);
		_Items = null;
		_LastMove = null;
	}
	
	public function AddItem(Data:ComboboxItem):ComboListItem
	{
		var Item:ComboListItem = new ComboListItem(Data);
		addChild(Item);
		
		Item.width = width - 10;
		Item.height = _ItemHeight;
		Item.x = 5;
		Item.y += 5;
		height = (this.Children.length + 1) * _ItemHeight + this.Children.length * 5;
		return Item;
	}
	
	protected var _ItemHeight:int = 15;
	public function set ItemHeight(Value:int):void
	{
		_ItemHeight = Value;
		for each( var Child:ComboListItem in _Items)
		{
			Child.height = Value;
		}
	}
	public function get ItemHeight():int
	{
		return _ItemHeight;
	}
	
	public function set ItemFocusColor(Value:uint):void
	{
		_FocusColor = Value;
	}
}

class ComboListItem extends Container
{
	private var _Icon:Bitmap = null;
	private var _Line:TextLine;
	private var _Item:ComboboxItem = null;
	public function ComboListItem(Data:ComboboxItem,Img:Bitmap = null)
	{
		super();
		this.Layout = LayoutConstant.HORIZONTAL;
		this.BorderThinkness = 0;
		_Item = Data;
		_Line = FontTextFactory.Instance.TextByStyle(_Item.Label,Style.FontTextStyle);
		
		addChild(_Line);
		_Line.y += _Line.textHeight;
	}
	
	public function set FontSize(Size:int):void
	{
		if(_Line && contains(_Line))
		{
			removeChild(_Line);
		}
		this.Style.FontTextStyle.FontSize = Size;	
		_Line = FontTextFactory.Instance.TextByStyle(_Item.Label,Style.FontTextStyle);
		_Line.y += _Line.textHeight;
		addChild(_Line);
	}
	
	public function get Item():ComboboxItem
	{
		return _Item;
	}
	
}

/**
 * 下拉框文本显示框
 * 
 * 
 **/
class ComboTextField extends UIControl
{
	private var _TextValue:String = "";
	private var _TextLine:TextLine = null;
	
	public function ComboTextField():void
	{
		super();
		this.BorderThinkness = 0;
		this.mouseEnabled = false;
	}
	
	public function set Text(Value:String):void
	{
		if(null != _TextLine && contains(_TextLine))
		{
			removeChild(_TextLine);
		}
		
		_TextValue = Tools.ReplaceAll(Value," ","");
		if(_TextValue != "")
		{
			_TextLine = FontTextFactory.Instance.TextByStyle(_TextValue,_Style.FontTextStyle);
			_TextLine.y += _TextLine.textHeight;
			_TextLine.x = 5;
			addChild(_TextLine);
		}
	}
}