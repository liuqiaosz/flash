package pixel.texture
{
	import flash.utils.ByteArray;
	
	import pixel.texture.vo.PixelTexture;
	import pixel.texture.vo.PixelTexturePackage;
	import pixel.utility.IDispose;
	import pixel.utility.ISerializable;
	
	use namespace PixelTextureNS;
	
	public interface IPixelTextureFactory extends IDispose
	{
		function encode(texturePackage:PixelTexturePackage):ByteArray;
		function decode(data:ByteArray):PixelTexturePackage;
		function asyncLoadTexture(texture:PixelTexture):void;
	}
}