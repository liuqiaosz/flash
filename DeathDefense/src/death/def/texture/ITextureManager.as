package death.def.texture
{
	import pixel.texture.vo.PixelTexture;
	import pixel.texture.vo.PixelTexturePackage;

	public interface ITextureManager
	{
		function download(url:String):void;
		function findTextureById(id:String):PixelTexture;
		function findTexturePackageById(id:String):PixelTexturePackage;
	}
}