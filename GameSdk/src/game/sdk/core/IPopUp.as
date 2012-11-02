package game.sdk.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public interface IPopUp
	{
		function PopUp(Obj:Sprite,Model:Boolean = false,Center:Boolean = false):void;
		function RemovePopUp(Obj:Sprite = null):void;
	}
}