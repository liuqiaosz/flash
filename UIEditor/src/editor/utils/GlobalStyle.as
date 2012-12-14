package editor.utils
{
	import editor.ui.StyleGroupFile;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIStyleFactory;
	import pixel.ui.control.style.UIStyleManager;
	import pixel.ui.control.vo.UIStyleGroup;
	import pixel.ui.control.vo.UIStyleMod;
	
	public class GlobalStyle
	{
		private static var _cache:Vector.<StyleGroupFile> = new Vector.<StyleGroupFile>();
		//private static var _cache:Vector.<UIStyleGroup> = new Vector.<UIStyleGroup>();
		public function GlobalStyle()
		{
			
		}
		
		public static function clear():void
		{
			_cache.length = 0;
		}
		
		public static function get styles():Vector.<StyleGroupFile>
		{
			return _cache;
		}
		
		public static function set styles(value:Vector.<StyleGroupFile>):void
		{
			_cache = value;
		}
		public static function addStyle(value:StyleGroupFile):void
		{
			_cache.push(value);
		}
		
		public static function refresh():void
		{
			UIStyleManager.instance.clearCache();
			_cache.length = 0;
			var defaultDir:File = new File(Common.DEFAULT_DIR_STYLES);
			if(defaultDir.exists && defaultDir.isDirectory)
			{
				var reader:FileStream = null;
				var files:Array = defaultDir.getDirectoryListing();
				
				for each(var file:File in files)
				{
					if(file.extension == "sg")
					{
						var styleFile:StyleGroupFile = new StyleGroupFile(file);
						_cache.push(styleFile);
						UIStyleManager.instance.addStyle(styleFile.styleGroup);
						//reader = new FileStream();
						//reader.open(file,FileMode.READ);
						//var data:ByteArray = new ByteArray();
						//reader.readBytes(data);
						//var group:UIStyleGroup = UIStyleFactory.instance.groupDecode(data);
						//dataProvider.addItem(group);
						//_cache.push(group);
						//reader.close();
					}
				}
			}
		}
	}
}