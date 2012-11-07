package mapassistant.resource
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import mapassistant.util.Tools;
	
	import utility.swf.Swf;

	public class Resource
	{
		public var SWF:Swf = null;
		//SWF文件路径
		public var SwfNavPath:String = "";
		
		//是否文件夹
		public var Direct:Boolean = false;
		
		//SWF文件是否加载完成
		public var SwfLoaded:Boolean = false;
		
		//资源列表
		private var _ChildrenItem:Vector.<ResourceItem> = new Vector.<ResourceItem>();
		
		//资源类映射
		private var _SourceDictionary:Dictionary = new Dictionary();
		
		public function get SwfFile():String
		{
			return SwfNavPath.substr((SwfNavPath.lastIndexOf(Tools.SystemSplitSymbol) + 1));
		}
		
		public function get SimpleName():String
		{
			return SwfNavPath.substring((SwfNavPath.lastIndexOf(Tools.SystemSplitSymbol) + 1),SwfNavPath.lastIndexOf("."));
		}
		
		public function Resource()
		{
		}
		
//		public function AddSourceDictionary(ClassName:String,Prototype:Class):void
//		{
//			if(!SourceDictionary)
//			{
//				SourceDictionary = new Dictionary();
//			}
//			SourceDictionary[ClassName] = Prototype;
//		}
//		public function GetSourceByName(ClassName:String):Class
//		{
//			return SourceDictionary[ClassName] as Class;
//		}
//		
//		public function AddNode(Node:ResourceItem):void
//		{
//			if(!_ChildrenItem)
//			{
//				_ChildrenItem = new Vector.<ResourceItem>();
//			}
//			_ChildrenItem.push(Node);
//		}
		
		public function AddSourceItem(Id:String,Source:Object,Type:uint,Owner:String):void
		{
			var Item:ResourceItem = new ResourceItem();
			Item.Id = Id;
			Item.Source = Source;
			Item.Type = Type;
			Item.Owner = Owner;
			_ChildrenItem.push(Item);
			_SourceDictionary[Id] = Item;
		}
		
		public function FindSourceByClass(Class:String):ResourceItem
		{
			return _SourceDictionary[Class] as ResourceItem;
		}
		
		public function get SourceDictionary():Dictionary
		{
			return _SourceDictionary;
		}
		
		
		/**
		 * 
		 * 根据类查找资源
		 * 
		 **/
//		public function FindItemByClass(Class:String):ResourceItem
//		{
//			for(var Idx:int=0; Idx<_ChildrenItem.length; Idx++)
//			{
//				if(_ChildrenItem[Idx].Class == Class)
//				{
//					return _ChildrenItem[Idx];
//				}
//			}
//			return null;
//		}
		
//		private var _BitmapDict:Dictionary = new Dictionary();
//		public function GetBitmapDictionary():Dictionary
//		{
//			return _BitmapDict;
//		}
//		
//		public function AddBitmap(Id:String,Img:Bitmap):void
//		{
//			_BitmapDict[Id] = Img;
//		}
		
		public function get ChildrenItem():Vector.<ResourceItem>
		{
			return _ChildrenItem;
		}
	}
}