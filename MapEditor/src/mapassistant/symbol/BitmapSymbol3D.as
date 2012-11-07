package mapassistant.symbol
{
	/**
	 * 2.5D地图使用元件
	 **/
	public class BitmapSymbol3D extends GenericSymbol
	{
		private var _SymbolRow:int = 0;
		public function set SymbolRow(Value:int):void
		{
			_SymbolRow = Value;
		}
		public function get SymbolRow():int
		{
			return _SymbolRow;
		}
		private var _SymbolColumn:int = 0;
		public function set SymbolColumn(Value:int):void
		{
			_SymbolColumn = Value;
		}
		public function get SymbolColumn():int
		{
			return _SymbolColumn;
		}
		private var _SymbolSize:int = 0;
		public function set SymbolSize(Value:int):void
		{
			_SymbolSize = Value;
		}
		public function get SymbolSize():int
		{
			return _SymbolSize;
		}
		
		
		public function BitmapSymbol3D()
		{
			super(TYPE_IMAGE_3D);
		}
	}
}