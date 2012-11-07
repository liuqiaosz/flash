package mapassistant.data
{
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	import mapassistant.error.DBError;

	public class Table implements ITable
	{
		private var Record:Dictionary = null;
		private var PrimaryKeyName:String = "";
		private var _TableName:String = "";
		
		public function Table()
		{
			Record = new Dictionary();
		}
		
		/**
		 * 
		 * 注册表字段名称
		 * 
		 **/
		protected function RegisterRecord(Name:String,FieldType:uint,FieldLength:int = 0):void
		{
			if(this.hasOwnProperty(Name))
			{
				var Field:TableField = new TableField();
				Field.FieldName = Name;
				Field.FieldType = FieldType;
				if(FieldType == TableFieldMode.STRING)
				{
					Field.FieldLength = FieldLength;
				}
				Record[Name] = Field;
			}
		}
		
		/**
		 * 
		 * 获取主键定义
		 * 
		 **/
		public function get PrimaryKeyField():TableField
		{
			if(this.PrimaryKeyName != "" && null != PrimaryKeyName)
			{
				return Record[PrimaryKeyName];
			}
			return null;
		}
		
		/**
		 * 
		 * 注册主键名称
		 * 
		 **/
		protected function RegisterPrimaryKey(Name:String):void
		{
			if(this.hasOwnProperty(Name))
			{
				PrimaryKeyName = Name;
			}
		}
		
		public function get GetPrimaryKey():String
		{
			return PrimaryKeyName;
		}
		
		/**
		 * 
		 * 获取所有已定义的表字段
		 * 
		 **/
		public function get GetDefinitionRecordName():Dictionary
		{
			return Record;
		}
		
		public function get TableSQL():String
		{
			if(_TableName == "" || null == _TableName)
			{
				throw new DBError("Invalid table name");
			}
			var SQL:String = "create table " + _TableName + "(";
			if(PrimaryKeyName != "" && null != PrimaryKeyName)
			{
				var PrimaryKeyField:TableField = Record[PrimaryKeyName];
				if(null != PrimaryKeyField)
				{
					SQL += (PrimaryKeyField.FieldName + " " + PrimaryKeyField.FieldTypeName + " PRIMARY KEY,");
				}
			}
			var Field:TableField = null;
			for(var Param:* in Record)
			{
				//绕过主键
				if(PrimaryKeyName != Param)
				{
					Field = Record[Param];
					SQL += 	(Field.FieldName + " " + Field.FieldTypeName + ",");
				}
			}
			SQL = SQL.substr(0,SQL.length - 1) + ")";
			return SQL;
		}
		
		public function get TableName():String
		{
			return _TableName;
		}
		public function set TableName(Value:String):void
		{
			_TableName = Value;
		}
		
		public function Clone():Object
		{
			return null;
		}
	}
}