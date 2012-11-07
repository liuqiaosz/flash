package mapassistant.symbol
{
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class SymbolFactory
	{
		private static var _SymbilCache:Dictionary = new Dictionary();
		public function SymbolFactory()
		{
			throw new Error("Cannot instance");
		}
		
		/**
		 * 从数据解码元件
		 **/
		public static function Decode(Data:ByteArray):GenericSymbol
		{
			var _Ver:int = Data.readByte();
			var _Type:int = Data.readByte();
			Data.position = 0;
			var Symbol:GenericSymbol = null;
			switch(_Type)
			{
				case GenericSymbol.TYPE_IMAGE_2D:
					Symbol = new BitmapSymbol2D();
					break;
				case GenericSymbol.TYPE_IMAGE_3D:
					Symbol = new BitmapSymbol3D();
			}
			
			if(Symbol)
			{
				Symbol.Decode(Data);
			}
			
			_SymbilCache[Symbol.Class] = Symbol;
			return Symbol;
		}
		
		public static function Encode(Symbol:GenericSymbol):ByteArray
		{
			return Symbol.Encode();
		}
		
		public static function SymbolExists(Class:String):Boolean
		{
			if(_SymbilCache[Class] == null)
			{
				return false;
			}
			return true;
		}
		
		public static function FindSymbolByClass(Class:String):GenericSymbol
		{
			return _SymbilCache[Class];
		}
	}
}