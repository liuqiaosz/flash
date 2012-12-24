package pixel.ui.control.asset
{
	import flash.utils.ByteArray;
	
	import pixel.texture.PixelTextureFactory;
	import pixel.texture.vo.PixelTexture;
	import pixel.texture.vo.PixelTexturePackage;

	public class PixelTextureAssetLibrary extends AssetLibrary
	{
		private var _texturePack:PixelTexturePackage = null;
		public function PixelTextureAssetLibrary(id:String,data:ByteArray)
		{
			super(id);
			_texturePack = PixelTextureFactory.instance.decode(data);
			var texture:PixelTexture = null;
			for each(texture in _texturePack.textures)
			{
				addAsset(new PixelTextureAsset(texture));
			}
		}
	}
}

import flash.display.Bitmap;
import pixel.texture.vo.PixelTexture;
import pixel.ui.control.asset.AssetImage;
import pixel.ui.control.asset.IAsset;

class PixelTextureAsset extends AssetImage implements IAsset
{
	private var _texture:PixelTexture = null;
	public function PixelTextureAsset(texture:PixelTexture)
	{
		super(texture.id);
		_texture = texture;
	}
	
	override public function get image():Bitmap
	{
		if(!_image)
		{
			_image = new Bitmap(_texture.bitmap);
		}
		return _image;
	}
}