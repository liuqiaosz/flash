package utility.swf
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import utility.swf.tag.BitJPEG2;
	import utility.swf.tag.BitLossless2;
	import utility.swf.tag.FileAttribute;
	import utility.swf.tag.GenericBit;
	import utility.swf.tag.GenericTag;
	import utility.swf.tag.SetBackgroundColor;
	import utility.swf.tag.SymbolClass;
	import utility.swf.tag.Tag;
	
	/**
	 * SWF文件解析
	 **/
	public class Swf
	{
		//private var _SwfVersion:int = 9;
		//private var _Compress:Boolean = true;
		
		private var _Stream:ByteStream = null;
		private var _Header:SwfHeader = null;
		private var _TagArray:Vector.<GenericTag> = null;
		private var _TagDictionary:Dictionary = null
		public function Swf(Stream:ByteStream = null)
		{
			_Stream = Stream;
			_TagArray = new Vector.<GenericTag>();
			_TagDictionary = new Dictionary();
			if(_Stream)
			{
				Initialize();
			}
			else
			{
				_Stream = new ByteStream();
				_Header = new SwfHeader();
				_Header.Sign = "FWS";
			}
		}
		
		/**
		 * SWF版本号
		 **/
		public function get Version():int
		{
			return _Header.Version;
		}
		public function set Version(Value:int):void
		{
			_Header.Version = Value;
		}
		
		/**
		 * 是否压缩
		 **/
		public function set Compress(Value:Boolean):void
		{
			if(Value)
			{
				_Header.Sign = "CWS";
			}
			else
			{
				_Header.Sign = "FWS";
			}
		}
		
		public function Encode():ByteStream
		{
			//SWF数据
			var SwfStream:ByteStream = new ByteStream();
			var Header:SwfHeader = new SwfHeader();
			
			//Tag数据
			var TagStream:ByteStream = new ByteStream();
			var FileAttr:FileAttribute = new FileAttribute();
			var SetBg:SetBackgroundColor = new SetBackgroundColor();
			TagStream.WriteBytes(FileAttr.Encode());
			TagStream.WriteBytes(SetBg.Encode());
			
			var SymbolTag:SymbolClass = new SymbolClass();
			
			for(var Idx:int=0; Idx<_TagArray.length; Idx++)
			{
				SymbolTag.AddSymbol(_TagArray[Idx].TagId,_TagArray[Idx].Id);
				TagStream.WriteBytes(_TagArray[Idx].Encode());
			}
			SwfStream.WriteBytes(TagStream);
			return SwfStream;
		}
		
		/**
		 * 获取SWF定义的所有图形数据
		 **/
		public function get BitmapAssets():Vector.<SwfBitmap>
		{
			var PNGBitmapTagList:Array = FindTagByType(Tag.LOSSLESS2);
			var JPGBitmapTagList:Array = FindTagByType(Tag.DEFINEJPEG2);
			
			var BitmapTagList:Array = PNGBitmapTagList.concat(JPGBitmapTagList);
			var SymbolTag:SymbolClass = FindTagByType(Tag.SYMBOLCLASS)[0];
			
			var BitmapTag:GenericBit = null;
			var SymbolName:String = "";
			var Vec:Vector.<SwfBitmap> = new Vector.<SwfBitmap>();
			if(SymbolTag && BitmapTagList.length > 0)
			{
				for(var Idx:int = 0; Idx<BitmapTagList.length; Idx++)
				{
					//处理图形
					BitmapTag = BitmapTagList[Idx];
					var Asset:SwfBitmap = new SwfBitmap();
					Asset.Id = SymbolTag.FindSymbolClassById(BitmapTag.TagId);
					Asset.Image = BitmapTag.Source as Bitmap;
					if(BitmapTag is BitJPEG2)
					{
						Asset.IsJPEG = true;
					}
					Vec.push(Asset);
				}
			}
			
			return Vec;
		}
		
//		public function get Header():SwfHeader
//		{
//			return _Header;
//		}
		
		/**
		 * SWF文件初始化
		 **/
		private function Initialize():void
		{
			_Header = new SwfHeader(_Stream);
			
			TagInitialize();
		}
		
		private var SymbolCount:int = 1;
		public function AddTag(TagItem:GenericTag):void
		{
			TagItem.TagId = SymbolCount;
			_TagArray.push(TagItem);
		}
		
		public function AddImage(Image:Bitmap,SymbolName:String):void
		{
			var BitlossTag:BitLossless2 = new BitLossless2();
			BitlossTag.BitmapWidth = Image.width;
			BitlossTag.BitmapHeight = Image.height;
			BitlossTag.Id = SymbolName;
			BitlossTag.BitmapBytes = new ByteStream(Image.bitmapData.getPixels(Image.bitmapData.rect));
			
			AddTag(BitlossTag);
		}
		
		private function TagInitialize():void
		{
			var SwfTag:GenericTag = null;
			while(_Stream.Position < _Stream.Length)
			{
				SwfTag = ReadTag();
				if(SwfTag)
				{
					_TagArray.push(SwfTag);
					if(SwfTag.TagId > 0)
					{
						_TagDictionary[SwfTag.Id] = SwfTag;
					}
				}
			}
		}
		
		/**
		 * 根据类型获取所有TAG
		 **/
		public function FindTagByType(Type:int):Array
		{
			var Result:Array = [];
			var SwfTag:GenericTag = null;
			for(var Idx:int=0; Idx<_TagArray.length; Idx++)
			{
				SwfTag = _TagArray[Idx];
				if(SwfTag.Type == Type)
				{
					Result.push(SwfTag);
				}
			}
			return Result;
		}
		
		public function GetAllImageTag():Array
		{
			var Result:Array = [];
			
			Result = this.FindTagByType(Tag.DEFINEJPEG2);
			Result = Result.concat(this.FindTagByType(Tag.LOSSLESS2));
			
			return Result;
		}
		
		public function FindTagById(Id:int):GenericTag
		{
			return _TagDictionary[Id] as GenericTag;
		}
		
		private function ReadTag():GenericTag
		{
			var Header:int = _Stream.ReadUI16();
			var Type:int = Header >> 6;
			var Len:uint = Header & 0x003F;
			if(Len == 0x3F)
			{
				Len = _Stream.ReadUI32();
			}
			var TagClass:Class = Tag.GetTagClassByType(Type);
			var Bytes:ByteStream = _Stream.ReadBytes(Len);
			if(TagClass)
			{
				return new TagClass(Bytes);
			}
			return null;
		}
	}
}