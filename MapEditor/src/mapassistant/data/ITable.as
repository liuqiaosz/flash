package mapassistant.data
{
	import flash.utils.Dictionary;
	
	import utility.IClone;

	public interface ITable extends IClone
	{
		function get GetDefinitionRecordName():Dictionary;
		function get TableSQL():String;
		function get TableName():String;
		function get PrimaryKeyField():TableField;
	}
}