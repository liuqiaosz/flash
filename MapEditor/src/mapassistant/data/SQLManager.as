package mapassistant.data
{
	import flash.filesystem.File;
	
	import mapassistant.util.Tools;

	/**
	 * 
	 * SQLITE管理类
	 * 
	 **/
	public class SQLManager
	{
		
		private static var DefaultSqlFile:String = File.applicationDirectory.nativePath + Tools.SystemSplitSymbol + "assets" + Tools.SystemSplitSymbol +  "Data.db";
		//private static var DefaultSqlFile:String = File.applicationStorageDirectory.resolvePath("datalib.db");
		private static var _Instance:SQLMangerImpl = null;
		
		public function SQLManager()
		{
			throw new Error("Invalid operation");
		}
		
		/**
		 * 
		 * 异步创建连接
		 * 
		 **/
		public static function GetConnectionAsync(Callback:Function):void
		{
			if(null == _Instance)
			{
				var SqlFile:File = new File(DefaultSqlFile);
				_Instance = new SQLMangerImpl(SqlFile);
			}
			
			_Instance.CreateConnectionAsync(Callback);
		}
		
		public static function GetConnection():SQL
		{
			if(_Instance == null)
			{
				var SqlFile:File = new File(DefaultSqlFile);
				_Instance = new SQLMangerImpl(SqlFile);
			}
			
			return _Instance.CreateConnection();
		}
	}
}

import flash.data.SQLConnection;
import flash.data.SQLResult;
import flash.data.SQLStatement;
import flash.errors.SQLError;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;
import flash.filesystem.File;
import flash.utils.Dictionary;

import mapassistant.data.ITable;
import mapassistant.data.SQL;
import mapassistant.data.TableField;
import mapassistant.data.TableFieldMode;
import mapassistant.error.DBError;

/**
 * 
 * 数据库管理类实现
 * 
 **/
class SQLMangerImpl
{
	private var SqlFile:File = null;
	public function SQLMangerImpl(SqlFile:File):void
	{
		this.SqlFile = SqlFile;
	}
	
	/**
	 * 
	 * 同步创建连接
	 * 
	 **/
	public function CreateConnection():SQL
	{
		if(null != SqlFile)
		{
			try
			{
				//同步交易
				var Conn:Connection = new Connection(SqlFile,false);
				return Conn;
			}
			catch(Err:Error)
			{
				trace(Err.message);
			}
		}
		return null;
	}
	
	/**
	 * 
	 * 异步创建连接
	 * 
	 **/
	public function CreateConnectionAsync(Callback:Function):void
	{
		new Connection(SqlFile,true,Callback);
		//Connection.addEventListener(SQLErrorEvent.ERROR,OnError);
	}
	
	/**
	 * 
	 * 创建连接异常
	 * 
	 **/
	private function OnError(event:SQLErrorEvent):void
	{
		
	}
}

/**
 * 
 * 数据库连接
 * 
 **/
class Connection extends flash.data.SQLConnection implements SQL
{
	private var _AsyncOpendCallback:Function = null;
	public function Connection(SqlFile:File,Async:Boolean,AsyncCallback:Function = null):void
	{
		super();
		if(Async)
		{
			_AsyncOpendCallback = AsyncCallback;
			addEventListener(SQLEvent.OPEN,OnConnectionOpened);
			this.openAsync(SqlFile);
		}
		else
		{
			this.open(SqlFile);
		}
	}
	
	private function OnConnectionOpened(event:SQLEvent):void
	{
		removeEventListener(SQLEvent.OPEN,OnConnectionOpened);
		if(null != _AsyncOpendCallback)
		{
			_AsyncOpendCallback(this);
		}
	}
	
	public function Save(Record:ITable):void
	{
		try
		{
			var SQL:String = BuildInsertSQL(Record);
			var Statement:SQLStatement = new SQLStatement();
			Statement.sqlConnection = this;
			Statement.text = SQL;
			Statement.execute();
		}
		catch(Err:Error)
		{
			trace(Err.message);
			throw new DBError("数据写入出错...");
		}
		//trace(Record.TableSQL);
		
	}
	public function Delete(Record:ITable):void
	{
	}
	public function Update(Record:ITable):void
	{
	}
	public function Query():Vector.<ITable>
	{
		return null;
	}
	
	/**
	 * 
	 * 执行SQL查询语句
	 * 
	 **/
	public function QueryBySQL(SQLText:String):Array
	{
		try
		{
			var Statement:SQLStatement = new SQLStatement();
			Statement.sqlConnection = this;
			Statement.text = SQLText;
			Statement.execute();
			var Result:SQLResult = Statement.getResult();
			return Result.data;
		}
		catch(Err:Error)
		{
			throw new DBError("数据写入出错...");
		}
		
		return [];
	}
	
	public function Close():void
	{
		this.close();
	}
	
	/**
	 * 
	 * 
	 * 插入语句
	 * 
	 **/
	private function BuildInsertSQL(Record:ITable):String
	{
		var TableName:String = Record.TableName;
		var SQL:String = "insert into " + TableName + "(";
		var Fields:Array = [];
		var FieldDict:Dictionary = Record.GetDefinitionRecordName;
		var Field:TableField = null;
		for(var FieldName:String in FieldDict)
		{
			Field = FieldDict[FieldName];
			Fields.push(Field);
			SQL += (Field.FieldName + ",");
		}
		
		SQL = SQL.substr(0,SQL.length -1) + ") values(";
		
		for(var Idx:int=0; Idx<Fields.length; Idx++)
		{
			Field = Fields[Idx];
			
			if(Field.FieldType == TableFieldMode.STRING)
			{
				SQL += ("'" + Record[Field.FieldName] + "',");
			}
			else
			{
				SQL += (Record[Field.FieldName] + ",");
			}
			
			
		}
		SQL = (SQL.substr(0,SQL.length -1)) + ")";
		trace(SQL);
		return SQL;
	}
}