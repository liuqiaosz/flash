package mapassistant.util
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class Tools
	{
		private static var Os:String = Capabilities.os.substr(0, 3);
		
		public function Tools()
		{
			
		}
		
		/**
		 * 
		 * 获取当前操作系统类型
		 * 
		 **/
		public static function get System():uint
		{
			if(Os == "Win")
			{
				return SystemMode.WINDOWS;
			}
			else if(Os == "Mac")
			{
				return SystemMode.MAC;
			}
			else
			{
				return SystemMode.LINUX;
			}
		}
		
		public static function get SystemSplitSymbol():String
		{
			if(System == SystemMode.WINDOWS)
			{
				return "\\";
			}
			else
			{
				return "/";
			}
		}
		
		public static function BitmapScale(Source:BitmapData,Size:int):BitmapData
		{
			var Scale:Number = Source.width > Source.height ? 
				(Source.width > Size ? Size /Source.width : 1) : 
				(Source.height > Size ? Size /Source.height : 1);
			
			var PreviewData:BitmapData = new BitmapData(Source.width * Scale,Source.height * Scale);
			var Mtx:Matrix = new Matrix();
			Mtx.scale(Scale,Scale);
			PreviewData.draw(Source,Mtx);
			return PreviewData;
		}
		
		public static function SaveDataToDisk(Data:ByteArray,Nav:String):void
		{
			var DiskFile:File = new File(Nav);
			
			try
			{
				var Writer:FileStream = new FileStream();
				Writer.open(DiskFile,FileMode.WRITE);
				Writer.writeBytes(Data,0,Data.length);
			}
			catch(Err:Error)
			{
				trace("Write file error : " + Err.message);
			}
			finally
			{
				if(Writer)
				{
					Writer.close();
					Writer = null;
				}
			}
		}
	}
}