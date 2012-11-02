package game.sdk.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Camera extends GameSprite
	{
		private var _Children:Vector.<GameSprite> = null;
		public function Camera()
		{
			super();
			_Children = new Vector.<GameSprite>();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(_Children.indexOf(child) < 0)
			{
				_Children.push(child as GameSprite);
				return super.addChild(child);
			}
			return child;
		}
		
		override public function Update():void
		{
			for each(var Spr:GameSprite in _Children)
			{
				Spr.Update();
			}
		}
	}
}