package utility.bitmap.tga
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class TGADecoder
	{
		public function TGADecoder()
		{
		}
		
		
		public function Decode(Data:ByteArray):BitmapData
		{
			Data.endian = Endian.LITTLE_ENDIAN;
			var Tga:TGAImage = new TGAImage();
			
			var MsgLen:int = Data.readByte();
			var Table:int = Data.readByte();
			var Type:int = Data.readByte();
			
			if(Table == 1)
			{
				
			}
			var vvv:int = Data.readShort();
			
			vvv = Data.readShort();
			vvv = Data.readByte();
			var X:int = Data.readShort();
			var Y:int = Data.readShort();
			var W:int = Data.readShort();
			var H:int = Data.readShort();
			
			var Bit:int = Data.readByte();
			var Desc:int = Data.readByte();
			
			var desc:TGADescription = new TGADescription(Desc);
			Bit = desc.Bit;
			
			var bit:BitmapData = new BitmapData(W,H);
			var v:Vector.<uint> = new Vector.<uint>();
			for(var i:int = 0; i < W * H; i++)
			{
				
				//Data.endian = Endian.BIG_ENDIAN;
				
				
//				var b:uint = Data.readUnsignedByte();
//				var g:uint = Data.readUnsignedByte();
//				var r:uint = Data.readUnsignedByte();
//				var a:uint = Data.readUnsignedByte();
//				
//				var c:RGBA = new RGBA(r,g,b,a);
				//var c:uint = a << 24 | r << 16 | g << 8 | b;
				v.push(Data.readInt());
				//Data.endian = Endian.BIG_ENDIAN;
				//v.push(Data.readUnsignedInt());
			}
			
			bit.setVector(new Rectangle(0,0,W,H),v);
			return bit;
		}
	}
}