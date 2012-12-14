package editor.ui
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.UIStyleFactory;
	import pixel.ui.control.vo.UIStyleGroup;

	public class StyleGroupFile
	{
		private var _file:File = null;
		public function StyleGroupFile(file:File)
		{
			_file = file;
			var reader:FileStream = new FileStream();
			reader.open(_file,FileMode.READ);
			var data:ByteArray = new ByteArray();
			reader.readBytes(data);
			_styleGroup = UIStyleFactory.instance.groupDecode(data);
		}
		
		public function get file():File
		{
			return _file;
		}
		
		private var _styleGroup:UIStyleGroup = null;
		public function get styleGroup():UIStyleGroup
		{
			return _styleGroup;
		}
		
		public function get id():String
		{
			return _styleGroup.id;
		}
		public function get desc():String
		{
			return _styleGroup.desc;
		}
		
		public function get styleCount():int
		{
			return _styleGroup.styleCount;
		}
	}
}