package pixel.tools.texture.utils
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import pixel.texture.PixelTextureEncodeEmu;
	import pixel.texture.vo.PixelTexture;
	import pixel.utility.BitmapTools;

	public class TextureEncoder
	{
		public function TextureEncoder()
		{
		}
		
		public static function textureEncode(texture:PixelTexture):void
		{
			try
			{
				//var source:BitmapData = BitmapTools.BitmapClone(texture.bitmap);
				var source:BitmapData = texture.bitmap.clone();
				//var pixels:ByteArray = _texture.bitmap.getPixels(_texture.bitmap.rect);
				//_texture.id = pixelTextureId.text;
				var compressPixels:ByteArray = null;
				var pixels:ByteArray = null;
				if(texture.encoderEnabled)
				{
					switch(texture.encoder)
					{
						case PixelTextureEncodeEmu.ENCODER_API:
							pixels = new ByteArray();
							source.encode(source.rect,PixelTextureEncodeEmu.getEncoder(texture.encodeType,texture.encodeQuality),pixels);
							break;
						case PixelTextureEncodeEmu.ENCODER_PIXEL:
							switch(texture.pixelCompressOp)
							{
								case PixelTextureEncodeEmu.PIXELENCODE_ARGB4444:
									pixels = BitmapTools.pixelsCompressToARGB4444(pixels);
									break;
								case PixelTextureEncodeEmu.PIXELENCODE_RGB565:
									pixels = BitmapTools.pixelsCompressToRGB565(pixels);
									break;
							}
							break;
					}
				}
				texture.source = pixels;
			}
			catch(err:Error)
			{}
		}
	}
}