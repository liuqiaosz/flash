package pixel.error
{
	public class PixelNetError extends PixelError
	{
		public static const NET_ERROR_ADDR:String = "Error_BadAddr";
		public function PixelNetError(errMsg:String,errId:int = 0)
		{
			super(errMsg,errId);
		}
	}
}