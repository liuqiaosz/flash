package pixel.message
{
	public class IOMessage extends PixelMessage
	{
		public static const KEYBOARD_INPUT:String = "KeyboardInput";
		public function IOMessage(msg:String,target:Object)
		{
			super(msg,target);
		}
	}
}