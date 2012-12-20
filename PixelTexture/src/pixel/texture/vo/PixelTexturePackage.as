package pixel.texture.vo
{
	import flash.utils.ByteArray;
	
	import pixel.utility.ISerializable;

	/**
	 * 纹理包
	 * 
	 * 
	 **/
	public class PixelTexturePackage
	{
		private var _textures:Vector.<PixelTexture> = null;
		public function PixelTexturePackage()
		{
			_textures = new Vector.<PixelTexture>();
		}
		
		public function addTexture(item:PixelTexture):void
		{
			_textures.push(item);
		}
		
		public function get textures():Vector.<PixelTexture>
		{
			return _textures;
		}
		
		public function getTextureAt(idx:int):PixelTexture
		{
			return _textures[idx];
		}
	}
}