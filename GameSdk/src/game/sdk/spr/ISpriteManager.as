package game.sdk.spr
{
	import utility.ISerializable;

	public interface ISpriteManager
	{
		function FindSpriteSheetOnGroup(GroupId:String,Id:String):ISpriteSheet;
		function FindSpriteSheetById(Id:String):ISpriteSheet;
		function Download(NavURL:String):void;
		
	}
}