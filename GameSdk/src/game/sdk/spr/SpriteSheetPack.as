package game.sdk.spr
{
	import flash.utils.ByteArray;
	
	import utility.ISerializable;
	import utility.Tools;

	public class SpriteSheetPack implements ISpriteSheetPack
	{
		private var _PackId:String = "";
		public function set PackId(Value:String):void
		{
			_PackId = Value;
		}
		public function get PackId():String
		{
			return _PackId;
		}
		
		private var _Sheets:Vector.<ISpriteSheet> = null;
		public function SpriteSheetPack()
		{
			_Sheets = new Vector.<ISpriteSheet>();	
		}
		
		public function get Sheets():Vector.<ISpriteSheet>
		{
			return _Sheets;
		}
		public function FindSheetById(Id:String):ISpriteSheet
		{
			var Sheet:ISpriteSheet = null;
			for each(Sheet in _Sheets)
			{
				if(Sheet.Id == Id)
				{
					return Sheet;
				}
			}
			return null;
		}
		
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			Data.writeByte(SpriteSheetMode.SHEETPACK);
			Data.writeByte(_Sheets.length);
			var Item:ISpriteSheet = null;
			var ItemData:ByteArray = null;
			for each(Item in _Sheets)
			{
				ItemData = Item.Encode();
				Data.writeBytes(ItemData,0,ItemData.length);
			}
			return Data;
		}
		
		public function Decode(Data:ByteArray):void
		{
			var Len:uint = Tools.ByteFinder(Data,32);
			_PackId = Data.readUTFBytes(Len);
			Data.readByte();
			Len = Data.readByte();
			var Item:ISpriteSheet = null;
			var ItemData:ByteArray = null;
			for(var Idx:uint=0; Idx<Len; Idx++)
			{
				Data.readByte();
				Item = new SpriteSheet();
				Item.Decode(Data);
				_Sheets.push(Item);
			}
		}
	}
}