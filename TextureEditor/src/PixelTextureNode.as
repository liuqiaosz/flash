package
{
	import flash.filesystem.File;
	
	import pixel.texture.vo.PixelTexture;

	public class PixelTextureNode extends PixelTexture
	{
		private var _file:File = null;
		public function get file():File
		{
			return _file;
		}
		public function PixelTextureNode(file:File)
		{
			super();
			_file = file;
		}
		
	}
}