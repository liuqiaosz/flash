package game.sdk.spr
{
	import utility.ISerializable;

	public interface ISpriteSheetPack extends ISerializable
	{
		function get PackId():String;
		function get Sheets():Vector.<ISpriteSheet>;
		function FindSheetById(Id:String):ISpriteSheet;
		
	}
}