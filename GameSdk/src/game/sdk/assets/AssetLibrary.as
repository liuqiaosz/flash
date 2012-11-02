package game.sdk.assets
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import utility.swf.ByteStream;
	import utility.swf.Swf;
	import utility.swf.tag.BitJPEG2;
	import utility.swf.tag.GenericBit;
	import utility.swf.tag.GenericTag;
	import utility.swf.tag.SymbolClass;
	import utility.swf.tag.Tag;
	
	public class AssetLibrary implements IAssetLibrary
	{
		//模块ID
		private var _Id:String = "";
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		public function get Id():String
		{
			return _Id;
		}
		
		//模块URL
		private var _Url:String = "";
		public function set Url(Value:String):void
		{
			_Url = Value;
		}
		public function get Url():String
		{
			return _Url;
		}
		
		private var _Data:ByteArray = null;
		public function set Data(Value:ByteArray):void
		{
			_Data = Value;
		}
		public function get Data():ByteArray
		{
			return _Data;
		}
		
		public function AssetLibrary()
		{
		}
		
		private var AssetDictionary:Dictionary = null;
		public function Decode():void
		{
			if(this._Data)
			{
				try
				{
					var Data:ByteArray = this.Data as ByteArray;
					if(Data)
					{
						Data.position = 0;
						var SwfReader:Swf = new Swf(new ByteStream(Data));
						var Symbol:SymbolClass = SwfReader.FindTagByType(Tag.SYMBOLCLASS)[0];
						var ImgArray:Array = SwfReader.GetAllImageTag();
						AssetDictionary = new Dictionary();
						for(var Idx:int=0; Idx<ImgArray.length; Idx++)
						{
							var ImgTag:GenericBit = ImgArray[Idx];
							var Class:String = Symbol.FindSymbolClassById(ImgTag.TagId);
							AssetDictionary[Class] = ImgTag;
						}
					}
				}
				catch(Err:Error)
				{
				}
			}
		}
		
		public function FindBitmapById(Id:String):Bitmap
		{
			if(AssetDictionary[Id])
			{
				return AssetDictionary[Id].Source as Bitmap;
			}
			return null;
		}
	}
}