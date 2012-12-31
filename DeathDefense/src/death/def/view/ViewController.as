package death.def.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class ViewController extends Sprite implements IViewController
	{
		private var _views:Vector.<Sprite> = null;
		public function ViewController()
		{
			_views = new Vector.<Sprite>();
		}
		
		public function addView(view:Sprite):void
		{
			if(_views.indexOf(view) < 0)
			{
				_views.push(view);
				addChild(view);
			}
		}
		
		public function removeView(view:Sprite):void
		{
			if(_views.indexOf(view) >= 0)
			{
				
				_views.splice(_views.indexOf(view),1);
				if(this.contains(view))
				{
					removeChild(view);
				}
			}
		}
		
		public function clearViews():void
		{
			var view:Sprite = null;
			while(view = _views.pop())
			{
				removeChild(view);
			}
		}
		
		public function initWithData(data:Object):void
		{
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			addView(child);
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			addView(child);
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			removeView(child);
		}
	}
}