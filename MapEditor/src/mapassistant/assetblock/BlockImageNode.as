package mapassistant.assetblock
{
	import flash.display.Bitmap;
	
	import mapassistant.ui.FlexImage;

	public class BlockImageNode extends FlexImage
	{
		private var _Row:int = 0;
		public function set Row(Value:int):void
		{
			_Row = Value;
		}
		public function get Row():int
		{
			return _Row;
		}
		private var _Column:int = 0;
		public function set Column(Value:int):void
		{
			_Column = Value;
		}
		public function get Column():int
		{
			return _Column;
		}
		
		private var _Block:AssetBlock = null;
		public function get OrignalBlock():AssetBlock
		{
			return _Block;
		}
		public function BlockImageNode(Image:Bitmap,Block:AssetBlock)
		{
			super(Image);
			_Block = Block
		}
	}
}