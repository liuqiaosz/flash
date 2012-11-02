package editor.model.asset
{
	public interface IAssetFactory
	{
		//创建新的资源库
		function CreateLibrary(Name:String):IAssetLibrary;
		//保存资产库
		function SaveLibrary(Library:IAssetLibrary):void;
		
		function OpenLibrary(Path:String):IAssetLibrary;
	}
}