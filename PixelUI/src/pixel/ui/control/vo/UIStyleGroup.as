package pixel.ui.control.vo
{
	import flash.utils.Dictionary;

	public class UIStyleGroup
	{
		private var _id:String = "";
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		private var _desc:String = "";
		public function set desc(value:String):void
		{
			_desc = value;
		}
		public function get desc():String
		{
			return _desc;
		}
		
		private var _styles:Vector.<UIStyleMod> = null;
		public function set styles(value:Vector.<UIStyleMod>):void
		{
			_styles = value;
		}
		public function get styles():Vector.<UIStyleMod>
		{
			return _styles;
		}
		public function UIStyleGroup(styles:Vector.<UIStyleMod> = null)
		{
			_styles = styles;
		}
		
		private var childMap:Dictionary = null;
		public function containStyle(id:String):Boolean
		{
			if(!childMap)
			{
				childMap = new Dictionary();
				var child:UIStyleMod = null;
				for each(child in _styles)
				{
					childMap[child.id] = child;
				}
			}
			
			return (id in childMap);
		}
		
		public function findStyleById(id:String):UIStyleMod
		{
			if(id in childMap)
			{
				return childMap[id];
			}
			return null;
		}
		
		public function get styleCount():int
		{
			if(_styles)
			{
				return _styles.length;
			}
			return 0;
		}
	}
}