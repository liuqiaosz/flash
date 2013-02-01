package pixel.ui.control
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.UIContainerStyle;
	import pixel.ui.control.utility.Utils;
	import pixel.ui.core.PixelUINS;
	
//	import pixel.utility.Tools;
	
	use namespace PixelUINS;
	/**
	 * 基础容器类,不提供视觉渲染
	 * 
	 * 定义子组件布局
	 * 定义子组件管理
	 * 响应子组件的更新
	 * 
	 **/
	public class UIContainer extends UIControl implements IUIContainer
	{
		//protected var _Padding:int = 0
		
		//布局样式,默认为绝对布局
		//private var _Layout:uint = LayoutConstant.ABSOLUTE;
		//子对象队列
		private var _Children:Array = [];
		public function UIContainer(Skin:Class = null)
		{
			var SkinStyle:Class = Skin ? Skin: UIContainerStyle;
			super(SkinStyle);
			_Content = new Sprite();
			
			super.addChild(_Content);
			//_Content.x = _Content.y = _Padding = _Style.BorderThinkness;
			_Content.x = _Content.y = _Style.BorderThinkness;
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			
			for each(var Child:UIControl in _Children)
			{
				Child.EnableEditMode();
			}
		}
		
		public function get Gap():int
		{
			return UIContainerStyle(Style).Gap;
		}
		public function set Gap(Value:int):void
		{
			UIContainerStyle(Style).Gap = Value;
			UpdateLayout();
		}
		
		public function set padding(value:int):void
		{
			UIContainerStyle(_Style).padding = value;
			//_Padding = Value;
			_Content.x = _Content.y = value + _Style.BorderThinkness;
			this.UpdateLayout();
		}
		public function get padding():int
		{
			return UIContainerStyle(_Style).padding;
		}
		
		override public function set BorderThinkness(Value:int):void
		{
			super.BorderThinkness = Value;
			_Content.x = _Content.y = UIContainerStyle(_Style).padding + Value;
		}
		
		public function get contentWidth():int
		{
			return width - (UIContainerStyle(_Style).padding * 2);
		}
		public function get contentHeight():int
		{
			return height - (UIContainerStyle(_Style).padding * 2);
		}
		
		/**
		 * 变更当前布局
		 **/
		public function set Layout(Value:uint):void
		{
			//判断是否与当前布局不一致
			if(UIContainerStyle(Style).Layout != Value)
			{
				UIContainerStyle(Style).Layout = Value;
				UpdateLayout();
			}
		}
		public function get Layout():uint
		{
			return UIContainerStyle(Style).Layout;
		}
		
		public function IsChildren(Obj:Object):Boolean
		{
			if(_Children.indexOf(Obj) < 0)
			{
				return false;
			}
			return true;
		}
		
		public function get ChildrenIds():Vector.<String>
		{
			var Vec:Vector.<String> = new Vector.<String>();
			var Child:IUIControl = null;
			for each(Child in _Children)
			{
				Vec.push(Child.Id);
			}
			return Vec;
		}
		
		/**
		 * 复写Sprite addChild函数.将添加的Child作为子组件保存并且进行布局调整
		 **/
		override public function addChild(Child:DisplayObject):DisplayObject
		{
			Append(Child);
			//return super.addChild(Child);
			
			return _Content.addChild(Child);
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			Remove(child);
			//return super.removeChild(child);
			_Content.removeChild(child);
			UpdateLayout();
			return child;
		}
		
		PixelUINS function OrignalAddChild(Child:DisplayObject):DisplayObject
		{
			//_Children.push(Child);
			
			return super.addChild(Child);
		}
		
		/**
		 * 复写Sprite addChildAt函数.将添加的Child作为子组件保存并且进行布局调整
		 **/
		override public function addChildAt(Child:DisplayObject, Index:int):DisplayObject
		{
			Append(Child);
			//return super.addChildAt(Child,Index);
			if(Child is UIControl)
			{
				UIControl(Child).Owner = this;
			}
			return _Content.addChildAt(Child,Index);
		}
		
		public function removeAllChildren():void
		{
			for each(var child:DisplayObject in _Children)
			{
				if(_Content.contains(child))
				{
					_Content.removeChild(child);
				}
			}
			
			_Children = [];
		}
		
		/**
		 * 更新布局,对所以子对象重新进行排序
		 **/
		protected function UpdateLayout():void
		{
			var Idx:int = 0;
			var Len:int = _Children ? _Children.length:0;
			var Seek:int = 0;
			var conWidth:int = contentWidth;
			var conHeight:int = contentHeight;
			switch(Layout)
			{
				case UILayoutConstant.HORIZONTAL:
					for(Idx=0; Idx<Len; Idx++)
					{
						_Children[Idx].x = Seek;
						_Children[Idx].y = 0;
						Seek = (_Children[Idx].x + _Children[Idx].width + Gap);
					}
					break;
				case UILayoutConstant.VERTICAL:
					for(Idx=0; Idx<Len; Idx++)
					{
						_Children[Idx].x = 0;
						_Children[Idx].y = Seek;
						Seek = (_Children[Idx].y + _Children[Idx].height + Gap);
					}
					break;
				case UILayoutConstant.GRID:
					var SeekY:int = 0;
					for(Idx=0; Idx<Len; Idx++)
					{
						if((Seek + _Children[Idx].width + Gap) > width)
						{
							Seek = 0;
							SeekY = (_Children[Idx - 1].height + Gap);
						}
						_Children[Idx].x = Seek;
						_Children[Idx].y = SeekY;
						Seek = (_Children[Idx].x + _Children[Idx].width + Gap);
					}
					break;
				default:
					break;
			}
		}
		
		private var _Content:Sprite = null;
		public function get Content():Sprite
		{
			return _Content;
		}
		
		public function get Children():Array
		{
			return _Children;
		}
		
		private function Remove(Child:DisplayObject):void
		{
			if(_Children.indexOf(Child) >= 0)
			{
				_Children.splice(_Children.indexOf(Child),1);
				
			}
		}
		
		/**
		 * 将子组件添加至管理队列.同时根据当前的布局状态进行布局调整
		 **/
		private function Append(Child:DisplayObject):void
		{
			if(!_Children)
			{
				_Children = [];
			}
			var pad:int = padding;
			var Last:DisplayObject = _Children.length > 0 ? _Children[_Children.length - 1]:null;
			switch(UIContainerStyle(Style).Layout)
			{
				case UILayoutConstant.HORIZONTAL:
					if(Last)
					{
						Child.x = Last.x + Last.width + Gap + pad;
						Child.y = Last.y;
					}
					else
					{
						Child.x = 0;
						Child.y = 0;
					}
					break;
				case UILayoutConstant.VERTICAL:
					if(Last)
					{
						Child.x = Last.x;
						Child.y = Last.y + Last.height + Gap;
					}
					else
					{
						Child.x = 0;
						Child.y = 0;
					}
					break;
				case UILayoutConstant.GRID:
					if(Last)
					{
						if((Last.x + Last.width + Child.width + Gap) >= width)
						{
							Child.x = 0;
							Child.y = Last.y + Last.height + Gap;
						}
						else
						{
							Child.x = (Last.x + Last.width + Gap);
							Child.y = Last.y;
						}
						
						if(Child.y + Child.height > height)
						{
							return;
						}
					}
					else
					{
						Child.x = 0;
						Child.y = 0;
					}
					break;
				default:
					break;
			}
			_Children.push(Child);
			UIControl(Child).Owner = this;
		}
		
		public function GetChildById(Id:String,DeepSearch:Boolean = false):IUIControl
		{
			var Item:IUIControl = null;
			for each(Item in _Children)
			{
				if(Item.Id == Id)
				{
					return Item;
				}
			}
			if(DeepSearch)
			{
				//深度查询
				var Vec:Vector.<UIControl> = this.AllChildren;
				for each(Item in Vec)
				{
					if(Item.Id == Id)
					{
						return Item;
					}
				}
			}
			return null;
		}
		
		override public function dispose():void
		{
			super.dispose();
			var child:UIControl = null;
			for each(child in _Children)
			{
				_Content.removeChild(child);
				child.dispose();
				child = null;
			}
		}
		
		/**
		 * 获取真实高度
		 * 
		 * 在有子对象的情况下计算所有子项的高度合+Gap
		 * 
		 **/
		override public function get RealHeight():Number
		{
			if(_Children && _Children.length > 0)
			{
				var child:UIControl = null;
				var size:int = 0;
				for each(child in  _Children)
				{
					size += child.height;
				}
				size += (_Children.length) * Gap + _Content.y;
				return size;
			}
			else
			{
				return super.height;
			}
		}
		
		override public function get RealWidth():Number
		{
			if(_Children && _Children.length > 0)
			{
				var child:UIControl = null;
				var size:int = 0;
				for each(child in  _Children)
				{
					size += child.width;
				}
				size += (_Children.length) * Gap + _Content.x;
				return size;
			}
			else
			{
				return super.RealWidth;
			}
		}
		
		public function OnDrop(Control:UIControl):void
		{
			addChild(Control);
		}
		
		/**
		 * 获取全部子控件,全部层级
		 * 
		 * 
		 **/
		public function get AllChildren():Vector.<UIControl>
		{
			var Vec:Vector.<UIControl> = new Vector.<UIControl>();
			
			var Child:UIControl = null;
			for each(Child in _Children)
			{
				Vec.push(Child);
				if(Child is UIContainer)
				{
					Vec = Vec.concat(UIContainer(Child).AllChildren);
				}
				
			}
			return Vec;
		}
		
		
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var ChildLen:int = Children.length;
			
			Data.writeByte(ChildLen);
			var Child:IUIControl = null;
			var ChildData:ByteArray = null;
			for(var Idx:int=0; Idx<ChildLen; Idx++)
			{
				Child = Children[Idx];
				//Data.writeByte(Utils.GetControlPrototype(Child));
				ChildData = Child.encode();
				Data.writeBytes(ChildData,0,ChildData.length);
			}
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			var ChildLen:int = Data.readByte();
			var Child:UIControl = null;
			var ChildData:ByteArray = null;
			var Prototype:Class = null;
			var Type:uint = 0;
			for(var Idx:int=0; Idx<ChildLen; Idx++)
			{
				Type = Data.readByte();
				Prototype = Utils.GetPrototypeByType(Type);
				Child = new Prototype() as UIControl;
				Child.decode(Data);
				addChild(Child);
			}
			
			padding = padding;
			this.UpdateLayout();
		}
		
		override public function set ImagePack(Value:Boolean):void
		{
			super.ImagePack = Value;
			var Child:UIControl = null;
			
			for each(Child in _Children)
			{
				Child.ImagePack = Value;
			}
		}
	}
}