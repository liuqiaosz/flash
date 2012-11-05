package utility.swf.tag
{
	import flash.utils.Dictionary;
	
	import utility.swf.ByteStream;

	public class SymbolClass extends GenericTag
	{
		private var _SymbolCount:int = 0;
		private var _SymbolDictionary:Dictionary = new Dictionary();
		public function SymbolClass(Stream:ByteStream = null)
		{
			super(Tag.SYMBOLCLASS,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			_SymbolCount = Stream.ReadUI16();
			var SymbolId:int = 0;
			_Keyset = new Vector.<String>();
			for(var Idx:int=0; Idx<_SymbolCount; Idx++)
			{
				SymbolId = Stream.ReadUI16();
				_SymbolDictionary[SymbolId] = Stream.FindString();
				_Keyset.push(_SymbolDictionary[SymbolId]);
			}
		}
		
		public function AddSymbol(Id:int,Name:String):void
		{
			_SymbolDictionary[Id] = Name;
			_SymbolCount++;
		}
		
		override public function Encode():ByteStream
		{
			Stream.WriteUI16(_SymbolCount);
			for(var SymbolId:* in _SymbolDictionary)
			{
				Stream.WriteUI16(SymbolId);
				Stream.WriteString(_SymbolDictionary[SymbolId]);
				Stream.WriteUI8(0);
			}
			return Stream;
		}
		
		public function FindSymbolClassById(Id:int):String
		{
			if(_SymbolDictionary.hasOwnProperty(Id))
			{
				return _SymbolDictionary[Id];
			}
			return "";
		}
		
		private var _Keyset:Vector.<String> = null;
		public function get SymbolKeyset():Vector.<String>
		{
			return _Keyset;
		}
		
		public function IsKeyContain(KeyName:String):Boolean
		{
			return (KeyName in _Keyset);
		}
	}
}