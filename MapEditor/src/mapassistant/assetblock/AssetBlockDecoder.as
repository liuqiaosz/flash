package mapassistant.assetblock
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import mapassistant.resource.Resource;
	import mapassistant.resource.ResourceItem;
	import mapassistant.resource.ResourceManager;
	
	public class AssetBlockDecoder
	{
		public function AssetBlockDecoder()
		{
		}
		
		public static function Decode(Data:ByteArray):AssetBlock
		{
			var Block:AssetBlock = new AssetBlock();
			var Len:int = Data.readByte();
			Block.Name = Data.readUTFBytes(Len);
			Block.ImageReference = Data.readByte();
			
			Len = Data.readByte();
			Block.ImageId = Data.readUTFBytes(Len);
			Block.UnitWidth = Data.readShort();
			Block.UnitHeight = Data.readShort();
			Block.OffsetX = Data.readShort();
			Block.OffsetY = Data.readShort();
			
			var ResArray:Vector.<Resource> = ResourceManager.Instance.SourceVec;
			for each(var Lib:Resource in ResArray)
			{
				var Item:ResourceItem = Lib.FindSourceByClass(Block.ImageId);
				if(Item)
				{
					Block.Image = Item.Source as Bitmap;
				}
			}
			return Block;
		}
	}
}