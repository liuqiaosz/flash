package editor.utils
{
	public interface IPreference
	{
		function get ScriptExport():String;
		function set ScriptExport(Value:String):void;
		function get ModelExport():String;
		function set ModelExport(Value:String):void;
		function get AssetPath():Array;
		function AppendAssetPath(Value:String):void;
		function DeleteAssetPath(Value:String):void;
		
		function AppendPackage(Value:String):void;
		function DeletePackage(Value:String):void;
		function get Packages():Array;
		function Save():void;
	}
}