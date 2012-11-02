package editor.model.asset
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * 图形资源模型
	 **/
	public class AssetBitmap extends Asset
	{
		private var _ImageWidth:uint = 0;
		public function set ImageWidth(Value:uint):void
		{
			_ImageWidth = Value;
		}
		public function get ImageWidth():uint
		{
			return _ImageWidth;
		}
		private var _ImageHeight:uint = 0;
		public function set ImageHeight(Value:uint):void
		{
			_ImageHeight = Value;
		}
		public function get ImageHeight():uint
		{
			return _ImageHeight;
		}
		private var _Image:Bitmap = null;
		public function AssetBitmap()
		{
		}
		
		override protected function DecodeSpecial(Data:ByteArray):void
		{
			_ImageWidth = Data.readShort();
			_ImageHeight = Data.readShort();
		}
		
		override protected function EncodeSpecial(Data:ByteArray):void
		{
			Data.writeShort(_ImageWidth);
			Data.writeShort(_ImageHeight);
		}
		
		public function get Image():Bitmap
		{
			if(_Image == null)
			{
				try
				{
					var ImageData:BitmapData = new BitmapData(_ImageWidth,_ImageHeight);
					ImageData.setPixels(ImageData.rect,Data);
					_Image = new Bitmap(ImageData);
				}
				catch(Err:Error)
				{
					trace(Err.message);
				}
			}
			
			return _Image;
		}
		public function set Image(Value:Bitmap):void
		{
			_Image = Value;
		}
	}
}