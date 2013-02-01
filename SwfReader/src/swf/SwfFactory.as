package swf
{
	/**
	 * SWF处理类
	 **/
	public class SwfFactory
	{
		private static var _Instance:ISwfProcess = null;
		public function SwfFactory()
		{
		}
		
		public static function get Instance():ISwfProcess
		{
			if(null == _Instance)
			{
				_Instance = new SwfFactoryImpl();
			}
			
			return _Instance;
		}
	}
}
import swf.ByteStream;
import swf.ISwfProcess;
import swf.Swf;
import swf.SwfRect;
import pixel.utility.swf.tag.BitLossless2;
import pixel.utility.swf.tag.FileAttribute;
import pixel.utility.swf.tag.GenericTag;
import pixel.utility.swf.tag.SetBackgroundColor;

import flash.utils.ByteArray;
import flash.utils.Endian;

class SwfFactoryImpl implements ISwfProcess
{
	public function SwfFactoryImpl()
	{
		
	}
	
	/**
	 * SWF文件编码
	 **/
	public function Encode(SwfFile:Swf):ByteArray
	{
		return null;
	}
	
	/**
	 * 
	 **/
	public function Decode(Source:ByteArray):Swf
	{
		try
		{
			var Stream:ByteStream = new ByteStream(Source);
			var SwfFile:Swf = new Swf(Stream);
//			while(Source.bytesAvailable > 0)
//			{
//				ReadTag(Source);
//			}
			return SwfFile;
		}
		catch(Err:Error)
		{
			trace(Err.message);
		}
		return null;
	}
	
	
	
	
}