package mapassistant.assetblock
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import mapassistant.resource.Resource;
	import mapassistant.resource.ResourceItem;
	import mapassistant.resource.ResourceManager;

	/**
	 * 图块数据编码器
	 * 
	 * 
	 **/
	public class AssetBlockEncoder
	{
		public function AssetBlockEncoder()
		{
		}
		
		public static function Encode(Item:AssetBlock):ByteArray
		{
			var Data:ByteArray = new ByteArray();
			
			Data.writeByte(Item.Name.length);
			Data.writeUTFBytes(Item.Name);
			Data.writeByte(Item.ImageReference);
			Data.writeByte(Item.ImageId.length);
			Data.writeUTFBytes(Item.ImageId);
			Data.writeShort(Item.UnitWidth);
			Data.writeShort(Item.UnitHeight);
			Data.writeShort(Item.OffsetX);
			Data.writeShort(Item.OffsetY);
			
			return Data;
		}
		
		
	}
}