package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.engine.TextLine;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.event.ComboboxEvent;
	import pixel.ui.control.style.UICombStyle;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.core.PixelUINS;
	
	use namespace PixelUINS;
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
			var StyleSkin:Class = Skin ? Skin:UICombStyle;
			super(StyleSkin);
			
			
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
			
			addEventListener(MouseEvent.MOUSE_DOWN,popup);
		}
		
		override public function dispose():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,popup);
		}
		
		override public function initializer():void
		{
//			_LabelField = new UITextInput("Combobox");
//			_LabelField.Input = false;
//			_LabelField.width = 100;
//			_LabelField.BorderThinkness = 0;
//			_LabelField.BackgroundAlpha = 0;
//			
//			buttonMode = true;
//			//_LabelField.
//			
//			_openButton = new UIButton();
//			
//			popDirection = POP_DOWN;
//			_openButton.NormalStyle.BackgroundImage = 
//				_openButton.MouseOverStyle.BackgroundImage = 
//				_openButton.MouseDownStyle.BackgroundImage = new Arrow_down() as Bitmap;
//			_openButton.width = _openButton.height = 16;
//			
//			
//			_openButton.NormalStyle.BorderThinkness = 
//				_openButton.MouseOverStyle.BorderThinkness = 
//				_openButton.MouseDownStyle.BorderThinkness = 0;
//			addChild(_LabelField);
//			addChild(_openButton);
//			
//			_List = new UIComboboxPop();
//			_List.height = 30;
//			addChild(_List);
//			_List.visible = false;
//			
//			width = 120;
//			height = 16;
		}
		
		public function get popButton():UIButton
		{
			return _openButton;
		}
		public function get popPanel():UIComboboxPop
		{
			return _List;
		}
		public function get labelField():UITextInput
		{
			return _LabelField;
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			removeEventListener(MouseEvent.MOUSE_DOWN,popup);
			this.mouseChildren = false;
			showPop();
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
		public function get popDirection():int
		{
			return _popDirection;
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
			_LabelField.width = width - _openButton.width - this.padding * 2;
			_LabelField.height = height;
			
			_LabelField.x = _LabelField.y = 0;
			_LabelField.y = (height - _LabelField.height) / 2;
			_openButton.x = _LabelField.width;
			_openButton.y = 0;
			positionUpdate();
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
			
			showPop();
		}
		
		public function showPop():void
		{
			positionUpdate();
			_List.visible = _Popup = true;
		}
		
		private function positionUpdate():void
		{
			if(_popDirection == 0)
			{
				_List.y = (_List.height + 2 + _Style.BorderThinkness) * -1;
			}
			else
			{
				_List.y = (height + 2);
			}
		}
		
		public function hidePop():void
		{
			_Popup = _List.visible = false;
		}
		
		public function set items(value:Vector.<ComboboxItem>):void
		{
			_List.items = value;
			showPop();
			//_Items = Value;
//			for each(var Item:ComboboxItem in value)
//			{
//				_List.AddItem(Item);
//			}
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
		
		override protected function SpecialDecode(data:ByteArray):void
		{
			data.readByte();
			_popDirection = data.readByte();
			//_LabelField = new UITextInput();
			_LabelField.decode(data);
			//_LabelField.Input = false;
			//_LabelField.width = 100;
			//_LabelField.BorderThinkness = 0;
			data.readByte();
			
			//_List = new UIComboboxPop();
			_List.decode(data);
			//_List.visible = false;
			data.readByte();
			//_openButton = new UIButton();
			_openButton.decode(data);
			
			//addChild(_LabelField);
			//addChild(_List);
			//addChild(_openButton);
		}
		override protected function SpecialEncode(data:ByteArray):void
		{
			data.writeByte(_popDirection);
			var childData:ByteArray = _LabelField.encode();
			data.writeBytes(childData,0,childData.length);
			childData = _List.encode();
			data.writeBytes(childData,0,childData.length);
			childData = _openButton.encode();
			data.writeBytes(childData,0,childData.length);
		}
	}
}

