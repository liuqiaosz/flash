package mapassistant.data.table
{
	import flashx.textLayout.factory.StringTextLineFactory;
	
	import mapassistant.data.Table;
	import mapassistant.data.TableFieldMode;

	/**
	 * 
	 * 元件数据库表对象
	 * 
	 **/
	public class TableSymbol extends Table
	{
		private var EntityData:Object = null;
		public var Name:String = "";
		public var BlockRow:int = 0;
		public var BlockColumn:int = 0;
		public var TileSize:int = 0;
		public var TileHeight:int = 0;
		public var ResourceLibrary:String = "";
		public var ResourceClass:String = "";
		public var OffsetX:int = 0;
		public var OffsetY:int = 0;
		public var SymbolType:int = 0;
		public var SymbolCategory:int = 0;
		public var ResourceName:String = "";
		public function TableSymbol(Data:Object = null)
		{
			EntityData = Data;
			TableName = "Symbol";
			RegisterRecord("Name",TableFieldMode.STRING,20);
			RegisterRecord("BlockRow",TableFieldMode.INT);
			RegisterRecord("BlockColumn",TableFieldMode.INT);
			RegisterRecord("TileSize",TableFieldMode.INT);
			RegisterRecord("TileHeight",TableFieldMode.INT);
			RegisterRecord("ResourceName",TableFieldMode.STRING,100);
			RegisterRecord("ResourceLibrary",TableFieldMode.STRING,100);
			RegisterRecord("ResourceClass",TableFieldMode.STRING,100);
			RegisterRecord("OffsetX",TableFieldMode.INT);
			RegisterRecord("OffsetY",TableFieldMode.INT);
			RegisterRecord("SymbolType",TableFieldMode.INT);
			RegisterRecord("SymbolCategory",TableFieldMode.INT);
			RegisterPrimaryKey("Name");
			
			if(Data)
			{
				Name = Data["Name"];
				BlockRow = Data["BlockRow"];
				BlockColumn = Data["BlockColumn"];
				TileSize = Data["TileSize"];
				TileHeight = Data["TileHeight"];
				ResourceName = Data["ResourceName"];
				ResourceLibrary = Data["ResourceLibrary"];
				ResourceClass = Data["ResourceClass"];
				OffsetX = Data["OffsetX"];
				OffsetY = Data["OffsetY"];
				SymbolType = Data["SymbolType"];
				SymbolCategory = Data["SymbolCategory"];
			}
		}
		
		override public function Clone():Object
		{
			var Table:TableSymbol = new TableSymbol(EntityData);
			return Table;
		}
	}
}