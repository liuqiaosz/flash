package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.engine.TextLine;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.ComboboxItem;
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIComboboxItem;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.UITextBase;
	import pixel.ui.control.style.FontStyle;
	import pixel.ui.core.NSPixelUI;
	import pixel.utility.Tools;

	use namespace NSPixelUI;
	public class UIComboboxPop extends UIContainer
	{
		private var _Items:Vector.<ComboboxItem> = new Vector.<ComboboxItem>();
		private var _LastMove:UIComboboxItem = null;
		private var _FocusColor:uint = 0xFFFFFF;
		
		public function UIComboboxPop()
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
			if(event.target is UIComboboxItem)
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
				
				_LastMove = event.target as UIComboboxItem;
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
		
		public function AddItem(Data:ComboboxItem):UIComboboxItem
		{
			var Item:UIComboboxItem = new UIComboboxItem(Data);
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
			for each( var Child:UIComboboxItem in _Items)
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
		
		public function get items():Vector.<ComboboxItem>
		{
			return _Items;
		}
		
		override protected function SpecialEncode(data:ByteArray):void
		{
			data.writeByte(_Items.length);
			var itemData:ByteArray = null;
			for each(var item:ComboboxItem in _Items)
			{
				itemData = item.Encode();
				data.writeBytes(itemData,0,itemData.length);
			}
//			var itemData:ByteArray = _Item.Encode();
//			data.writeBytes(itemData,0,itemData.length);
		}
		
		override protected function SpecialDecode(data:ByteArray):void
		{
			var len:int = data.readByte();
			var item:ComboboxItem = null;
			for(var idx:int = 0; idx<len; idx++)
			{
				item = new ComboboxItem();
				item.Decode(data);
				this.AddItem(item);
			}
//			_Item = new ComboboxItem();
//			_Item.Decode(Data);
//			_text.Text = _Item.Label;
//			_text.FontColor = _Item.fontColor;
//			_text.FontBold = _Item.fontBold;
//			_text.FontSize = _Item.fontSize;
		}
	}
}