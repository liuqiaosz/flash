package pixel.error
{
	public class PixelError extends Error
	{
		public function PixelError(errMsg:String,errId:int = 0)
		{
			super(errMsg,errId);
		}
	}
}