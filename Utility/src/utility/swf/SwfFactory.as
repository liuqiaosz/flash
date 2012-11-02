package utility.swf
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
import utility.swf.ByteStream;
import utility.swf.ISwfProcess;
import utility.swf.Swf;
import utility.swf.SwfRect;
import utility.swf.tag.BitLossless2;
import utility.swf.tag.FileAttribute;
import utility.swf.tag.GenericTag;
import utility.swf.tag.SetBackgroundColor;

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