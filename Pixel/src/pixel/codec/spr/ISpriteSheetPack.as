package pixel.codec.spr
{
	import pixel.codec.ICoder;
	
	public interface ISpriteSheetPack extends ICoder
	{
		function get PackId():String;
		function get Sheets():Vector.<ISpriteSheet>;
		function FindSheetById(Id:String):ISpriteSheet;
		
	}
}