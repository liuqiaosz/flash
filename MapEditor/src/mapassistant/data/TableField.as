package mapassistant.data
{
	public class TableField
	{
		public var FieldName:String = "";
		public var FieldType:uint = 0;
		public var FieldLength:int = 0;
		public function TableField()
		{
		}
		
		public function get FieldTypeName():String
		{
			switch(FieldType)
			{
				case TableFieldMode.INT:
					return "int"
					break;
				case TableFieldMode.STRING:
					return "varchar(" + FieldLength + ")";
					break;
			}
			return null;
		}
	}
}