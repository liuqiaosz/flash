package pixel.utility.bitmap.png
{
	import flash.utils.ByteArray;
	
	import pixel.utility.ColorCode;
	import pixel.utility.ISerializable;

	/**
	 * PNG解码
	 * 
	 * 
	 **/
	public class PNGDecoder implements ISerializable
	{
		protected var _IHDR:BlockIHDR = null;
		public function get IHDR():BlockIHDR
		{
			return _IHDR;
		}
		protected var _Palatte:BlockPLTE = null;
		protected var _TRNS:BlockTRNS = null;
		protected var DataVec:Vector.<ByteArray> = new Vector.<ByteArray>();
		public function PNGDecoder()
		{
			
		}
		
		public function Encode():ByteArray
		{
			return null;
		}
		
		private var header:ByteArray = new ByteArray();
		public function Decode(Data:ByteArray):void
		{
			//读取PNG头
			Data.readBytes(header,0,8);
			while(Data.bytesAvailable > 0)
			{
				BlockDecode(Data);
			}
		}
		
		private function BlockDecode(Data:ByteArray):void
		{
			var Len:int = Data.readInt();
			var BlockId:String = Data.readUTFBytes(4);
			var BlockData:ByteArray = new ByteArray();
			trace(BlockId);
			Data.readBytes(BlockData,0,Len);
			
			switch(BlockId)
			{
				case "IHDR":
					_IHDR = new BlockIHDR();
					_IHDR.PNGWidth = BlockData.readInt();
					_IHDR.PNGHeight = BlockData.readInt();
					_IHDR.BitDepth = BlockData.readUnsignedByte();
					_IHDR.ColorType = BlockData.readUnsignedByte();
					_IHDR.Compression = BlockData.readUnsignedByte();
					_IHDR.Filter = BlockData.readUnsignedByte();
					_IHDR.Interlace = BlockData.readUnsignedByte();
					break;
				case "tEXt":
					//trace(BlockData.readUTFBytes(BlockData.length));
					break;
				case "iTXt":
					//trace(BlockData.readUTFBytes(BlockData.length));
					break;
				case "PLTE":
					_Palatte = new BlockPLTE();
					var Red:int = 0;
					var Green:int = 0;
					var Blue:int = 0;
					while(BlockData.bytesAvailable > 0)
					{
						Red = BlockData.readByte();
						Green = BlockData.readByte();
						Blue = BlockData.readByte();
						_Palatte.PushPixel(ColorCode.ColorRGB(Red,Green,Blue));
					}
					break;
				case "TRNS":
					_TRNS = new BlockTRNS();
					while(BlockData.bytesAvailable > 0)
					{
						_TRNS.PushAlpha(BlockData.readByte());
					}
					break;
				case "IDAT":
					DataVec.push(BlockData);
					
					BlockData.compress();
					break;
				case "IEND":
					return;
					
			}
			var CRCCode:int = Data.readInt();
		}
	}
}
import flash.utils.ByteArray;

import pixel.utility.bitmap.png.BlockGenericText;

class BlockText extends BlockGenericText
{
	public function BlockText(Data:ByteArray)
	{
		_Keyword = Data.readUTFBytes(78);
		_Separator = Data.readByte();
		_TextData = new ByteArray();
		Data.readBytes(_TextData,0);
	}
}

/**
 * Keyword:             1-79 bytes (character string)
   Null separator:      1 byte
   Compression flag:    1 byte
   Compression method:  1 byte
   Language tag:        0 or more bytes (character string)
   Null separator:      1 byte
   Translated keyword:  0 or more bytes
   Null separator:      1 byte
   Text:                0 or more bytes
 **/
class BlockItxt extends BlockGenericText
{
	protected var _Compression:Boolean = false;
	protected var _CompressionMethod:int = 0;
	protected var _Language:String = "";
	public function BlockItxt(Data:ByteArray)
	{
		_Keyword = Data.readUTFBytes(78);
		_Separator = Data.readByte();
		
		_TextData = new ByteArray();
		Data.readBytes(_TextData,0);
	}
}

class BlockTRNS
{
	protected var _AlphaMap:Vector.<uint> = null;
	public function BlockTRNS()
	{
		_AlphaMap = new Vector.<uint>();
	}
	
	public function PushAlpha(Value:int):void
	{
		_AlphaMap.push(Value);
	}
}
class BlockPLTE
{
	protected var _Palatte:Vector.<uint> = null;
	public function BlockPLTE()
	{
		_Palatte = new Vector.<uint>();
	}
	
	public function PushPixel(Pixel:uint):void
	{
		_Palatte.push(Pixel);
	}
	
	public function get Palatte():Vector.<uint>
	{
		return _Palatte;
	}
}

class BlockIHDR
{
	
	private var _PNGWidth:int = 0;
	public function set PNGWidth(Value:int):void
	{
		_PNGWidth = Value;
	}
	public function get PNGWidth():int
	{
		return _PNGWidth;
	}
	private var _PNGHeight:int = 0;
	public function set PNGHeight(Value:int):void
	{
		_PNGHeight = Value;
	}
	public function get PNGHeight():int
	{
		return _PNGHeight;
	}
	private var _BitDepth:int = 0;
	public function set BitDepth(Value:int):void
	{
		_BitDepth = Value;
	}
	public function get BitDepth():int
	{
		return _BitDepth;
	}
	private var _ColorType:int = 0;
	public function set ColorType(Value:int):void
	{
		_ColorType = Value;
	}
	public function get ColorType():int
	{
		return _ColorType;
	}
	
	private var _Compression:int = 0;
	public function set Compression(Value:int):void
	{
		_Compression = Value;
	}
	public function get Compression():int
	{
		return _Compression;
	}
	
	private var _Filter:int = 0;
	public function set Filter(Value:int):void
	{
		_Filter = Value;
	}
	public function get Filter():int
	{
		return _Filter;
	}
	
	private var _Interlace:int = 0;
	public function set Interlace(Value:int):void
	{
		_Interlace = Value;
	}
	public function get Interlace():int
	{
		return _Interlace;
	}
}