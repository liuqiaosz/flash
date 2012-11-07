package mapassistant.data
{
	public interface SQL
	{
		function Save(Record:ITable):void;
		function Delete(Record:ITable):void;
		function Update(Record:ITable):void;
		function Query():Vector.<ITable>;
		function Close():void;
		function QueryBySQL(SQLText:String):Array;
	}
}