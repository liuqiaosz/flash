package pixel.utility.atlas.starling.vo
{
	public class TextureAtlas
	{
		public var imagePath:String = "";
			
		private var _textures:Vector.<SubTexture> = null;
		public function TextureAtlas()
		{
			_textures = new Vector.<SubTexture>();
		}
		
		public function pushTexture(texture:SubTexture):void
		{
			_textures.push(texture);
		}
	}
}