package game.sdk.spr
{
	import utility.ISerializable;

	public interface ISpriteSheet extends ISerializable
	{
		function PushFrame(Frame:SpriteSheetFrame):void;
		function PopFrame():SpriteSheetFrame;
		function ShiftFrame():SpriteSheetFrame;
		function NextFrame():SpriteSheetFrame;
		function PrevFrame():SpriteSheetFrame;
		function GetFrameByIndex(Idx:uint):SpriteSheetFrame;
		function get Frames():Vector.<SpriteSheetFrame>;
		function set Position(Idx:uint):void;
		function get Position():uint;
		function get Delay():uint;
		function set Delay(Value:uint):void;
		function get Id():String;
		
		function get IsLast():Boolean;
	}
}