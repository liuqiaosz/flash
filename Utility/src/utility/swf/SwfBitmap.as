package utility.swf
{
	import flash.display.Bitmap;

	public class SwfBitmap
	{
		private var _Id:String = "";
		private var _Image:Bitmap = null;
		private var _IsJPEG:Boolean = false;
		public function set IsJPEG(Value:Boolean):void
		{
			_IsJPEG = Value;
		}
		public function get IsJPEG():Boolean
		{
			return _IsJPEG;
		}
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		public function get Id():String
		{
			return _Id;
		}
		
		public function set Image(Value:Bitmap):void
		{
			_Image = Value;
		} 
		public function get Image():Bitmap
		{
			return _Image;
		}
		public function SwfBitmap()
		{
		}
	}
}