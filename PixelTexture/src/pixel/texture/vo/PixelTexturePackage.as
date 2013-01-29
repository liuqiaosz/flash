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
		private var _isAnim:Boolean = false;
		public function set isAnim(value:Boolean):void
		{
			_isAnim = value;
		}
		public function get isAnim():Boolean
		{
			return _isAnim;
		}
		private var _playGap:int = 0;
		public function set playGap(value:int):void
		{
			_playGap = value;
		}
		public function get playGap():int
		{
			return _playGap;
		}
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