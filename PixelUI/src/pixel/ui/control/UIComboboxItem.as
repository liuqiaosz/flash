package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import pixel.ui.core.PixelUINS;
	import pixel.ui.control.vo.ComboboxItem;
	
	use namespace PixelUINS;
	
	public class UIComboboxItem  extends UIContainer
	{
		private var _Icon:Bitmap = null;
		//private var _Line:TextLine;
		private var _text:UILabel = null;
		private var _Item:ComboboxItem = null;
		public function UIComboboxItem(Data:ComboboxItem = null,Img:Bitmap = null)
		{
			super();
			this.Layout = UILayoutConstant.HORIZONTAL;
			this.BorderThinkness = 0;
			this.BackgroundAlpha = 0;
			_Item = Data;
			_text = new UILabel();
			addChild(_text);
			if(_Item)
			{
				_text.text = _Item.Label;
				_text.FontColor = _Item.fontColor;
				_text.FontBold = _Item.fontBold;
				_text.FontSize = _Item.fontSize;
			}
			this.mouseChildren = false;
		}
		
		public function set FontSize(Size:int):void
		{
			//this.Style.FontTextStyle.FontSize = Size;	
			_text.FontSize = Size;
			addChild(_text);
		}
		
		public function get Item():ComboboxItem
		{
			return _Item;
		}
		
		override protected function SpecialEncode(data:ByteArray):void
		{
			var itemData:ByteArray = _Item.encode();
			data.writeBytes(itemData,0,itemData.length);
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			_Item = new ComboboxItem();
			_Item.decode(Data);
			_text.text = _Item.Label;
			_text.FontColor = _Item.fontColor;
			_text.FontBold = _Item.fontBold;
			_text.FontSize = _Item.fontSize;
		}
	}
}