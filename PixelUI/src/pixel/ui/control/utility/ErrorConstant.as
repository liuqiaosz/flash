package pixel.ui.control.utility
{
	public class ErrorConstant
	{
		public static const ONLYSINGLTON:String = "Singlton mode";
		public function ErrorConstant()
		{
			throw new Error(ONLYSINGLTON);
		}
	}
}