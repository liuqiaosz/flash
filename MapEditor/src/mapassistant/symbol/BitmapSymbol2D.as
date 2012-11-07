package mapassistant.symbol
{
	import flash.utils.ByteArray;

	/**
	 * 2D TILE地图用元件
	 **/
	public class BitmapSymbol2D extends GenericSymbol
	{
		public function BitmapSymbol2D()
		{
			super(TYPE_IMAGE_2D);
		}
		
		override public function Encode():ByteArray
		{
			var Data:ByteArray = super.Encode();
			
			return Data;
		}
		
		override public function Decode(Data:ByteArray):void
		{
			super.Decode(Data);
			
		}
	}
}