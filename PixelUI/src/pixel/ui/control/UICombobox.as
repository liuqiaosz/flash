package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.engine.TextLine;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.event.ComboboxEvent;
	import pixel.ui.control.style.CombStyle;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.core.NSPixelUI;
	
	use namespace NSPixelUI;
	/**
	 * 下拉框
	 * 上拉框
	 * 
	 **/
	public class UICombobox extends UIContainer
	{
		public static const POP_UP:int = 0;
		public static const POP_DOWN:int = 1;
		
		[Embed(source="ArrowDown.png")]
		private var Arrow_down:Class;
		[Embed(source="ArrowUp.png")]
		private var Arrow_up:Class;
		
		private var _LabelField:UITextInput = null;
		//private var _Items:Vector.<ComboboxItem> = null;
		private var _List:UIComboboxPop = null;
		private var _Popup:Boolean = false;
		private var _openButton:UIButton = null;
		protected var _popDirection:int = 0;
		
		public function UICombobox(Skin:Class = null)
		{
			var StyleSkin:Class = Skin ? Skin:CombStyle;
			super(StyleSkin);
			addEventListener(MouseEvent.MOUSE_DOWN,popup);
			
		}
		
		override public function initializer():void
		{
			_LabelField = new UITextInput("Combobox");
			_LabelField.Input = false;
			_LabelField.width = 100;
			_LabelField.BorderThinkness = 0;
			_LabelField.BackgroundAlpha = 0;
			buttonMode = true;
			//_LabelField.
			
			_openButton = new UIButton();
			
			popDirection = POP_DOWN;
			_openButton.NormalStyle.BackgroundImage = 
				_openButton.MouseOverStyle.BackgroundImage = 
				_openButton.MouseDownStyle.BackgroundImage = new Arrow_down() as Bitmap;
			_openButton.width = _openButton.height = 16;
			
			
			_openButton.NormalStyle.BorderThinkness = 
				_openButton.MouseOverStyle.BorderThinkness = 
				_openButton.MouseDownStyle.BorderThinkness = 0;
			addChild(_LabelField);
			addChild(_openButton);
			
			_List = new UIComboboxPop();
			_List.height = 30;
			addChild(_List);
			_List.visible = false;
			
			width = 120;
			height = 16;
		}
		
		public function get popButton():UIButton
		{
			return _openButton;
		}
		public function get popPanel():UIComboboxPop
		{
			return _List;
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			removeEventListener(MouseEvent.MOUSE_DOWN,popup);
			this.mouseChildren = false;
			listPopUp();
		}
		
		/**
		 * 修改弹出的方向
		 * 默认向上弹出
		 * 
		 * 
		 **/
		public function set popDirection(value:int):void
		{
			_popDirection = value;
			
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_List.width = value;
			sizeUpdate();
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			sizeUpdate();
		}
		
		private function sizeUpdate():void
		{
			_openButton.width = height;
			_openButton.height = height;
			//按钮右边空出2个padding的像素
			_LabelField.width = width - _openButton.width - this._Padding * 2;
			_LabelField.height = height;
			
			_LabelField.x = _LabelField.y = 0;
			_openButton.x = _LabelField.width;
			_openButton.y = 0;
		}
		
		private function popup(event:MouseEvent):void
		{
			var Sender:Object = event.target;
			if(event.target is UIComboboxItem)
			{
				var Item:UIComboboxItem = Sender is TextLine ? TextLine(Sender).parent as UIComboboxItem:Sender as UIComboboxItem;
				if(Item)
				{
					var Notify:ComboboxEvent = new ComboboxEvent(ComboboxEvent.SELECT);
					Notify.Item = Item.Item;
					dispatchEvent(Notify);
					_LabelField.Text = Item.Item.Label;
				}
			}
			
			listPopUp();
		}
		
		private function listPopUp():void
		{
			if(_popDirection == 0)
			{
				_List.y = (_List.height + 2) * -1;
				_List.visible = !_Popup;
				_Popup = _List.visible;
			}
			else
			{
				_List.y = (height + 2);
				_List.visible = !_Popup;
				_Popup = _List.visible;
			}
		}
		
		public function set items(value:Vector.<ComboboxItem>):void
		{
			//_Items = Value;
			for each(var Item:ComboboxItem in value)
			{
				_List.AddItem(Item);
			}
		}
		public function get items():Vector.<ComboboxItem>
		{
			return _List.items;
		}
//		public function get items():Vector.<ComboboxItem>
//		{
//			return _Items;
//		}
		
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
			this.removeEventListener(MouseEvent.MOUSE_DOWN,popup);
		}
		
		override protected function SpecialDecode(data:ByteArray):void
		{
			data.readByte();
			_LabelField = new UITextInput();
			_LabelField.Decode(data);
			_LabelField.Input = false;
			_LabelField.width = 100;
			_LabelField.BorderThinkness = 0;
			data.readByte();
			
			_List = new UIComboboxPop();
			_List.Decode(data);
			_List.visible = false;
			data.readByte();
			_openButton = new UIButton();
			_openButton.Decode(data);
			
			addChild(_LabelField);
			addChild(_List);
			addChild(_openButton);
		}
		override protected function SpecialEncode(data:ByteArray):void
		{
			var childData:ByteArray = _LabelField.Encode();
			data.writeBytes(childData,0,childData.length);
			childData = _List.Encode();
			data.writeBytes(childData,0,childData.length);
			childData = _openButton.Encode();
			data.writeBytes(childData,0,childData.length);
		}
	}
}
//import flash.display.Bitmap;
//import flash.display.Sprite;
//import flash.events.MouseEvent;
//import flash.text.engine.TextLine;
//import flash.ui.Mouse;
//import flash.ui.MouseCursor;
//
//import pixel.ui.control.ComboboxItem;
//import pixel.ui.control.LayoutConstant;
//import pixel.ui.control.UIComboboxItem;
//import pixel.ui.control.UIContainer;
//import pixel.ui.control.UIControl;
//import pixel.ui.control.UILabel;
//import pixel.ui.control.UITextBase;
//import pixel.ui.control.style.FontStyle;
//import pixel.ui.core.NSPixelUI;
//import pixel.utility.Tools;
//
//use namespace NSPixelUI;
//
//class ComboItemList extends UIContainer
//{
//	private var _Items:Vector.<UIComboboxItem> = new Vector.<UIComboboxItem>();
//	private var _LastMove:UIComboboxItem = null;
//	private var _FocusColor:uint = 0xFFFFFF;
//	
//	public function ComboItemList()
//	{
//		
//		super();
//		this.Layout = LayoutConstant.VERTICAL;
//		this.BorderThinkness = 1;
//		width = 150;
//		//height = 150;
//		this.addEventListener(MouseEvent.MOUSE_OVER,FocusMove);
//		this.addEventListener(MouseEvent.MOUSE_OUT,function(event:MouseEvent):void{
//			
//			Mouse.cursor = MouseCursor.AUTO;
//		});
//	}
//	
//	private function FocusMove(event:MouseEvent):void
//	{
//		Mouse.cursor = MouseCursor.BUTTON;
//		if(event.target is UIComboboxItem)
//		{
//			if(_LastMove == event.target)
//			{
//				return;
//			}
//			if(_LastMove)
//			{
//				_LastMove.BackgroundColor = 0xFFFFFF;
//				_LastMove.BackgroundAlpha = 1;
//			}
//			
//			_LastMove = event.target as UIComboboxItem;
//			_LastMove.BackgroundColor = _FocusColor;
//			_LastMove.BackgroundAlpha = 0.6;
//		}
//	}
//	
//	
//	override public function Dispose():void
//	{
//		this.removeEventListener(MouseEvent.MOUSE_OVER,FocusMove);
//		_Items = null;
//		_LastMove = null;
//	}
//	
//	public function AddItem(Data:ComboboxItem):UIComboboxItem
//	{
//		var Item:UIComboboxItem = new UIComboboxItem(Data);
//		addChild(Item);
//		
//		Item.width = width - 10;
//		Item.height = _ItemHeight;
//		Item.x = 5;
//		Item.y += 5;
//		height = (this.Children.length + 1) * _ItemHeight + this.Children.length * 5;
//		return Item;
//	}
//	
//	protected var _ItemHeight:int = 15;
//	public function set ItemHeight(Value:int):void
//	{
//		_ItemHeight = Value;
//		for each( var Child:UIComboboxItem in _Items)
//		{
//			Child.height = Value;
//		}
//	}
//	public function get ItemHeight():int
//	{
//		return _ItemHeight;
//	}
//	
//	public function set ItemFocusColor(Value:uint):void
//	{
//		_FocusColor = Value;
//	}
//}
