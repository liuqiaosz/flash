package pixel.utility
{
	public class DateTools
	{
		public function DateTools()
		{
		}
		
		public static function get Year():int
		{
			var D:Date = new Date();
			return D.fullYear;
		}
		
		public static function get Day():int
		{
			var D:Date = new Date();
			return D.day;
		}
		
		public static function get Month():int
		{
			var D:Date = new Date();
			return D.month;
		}
		
		public static function get Hour():int
		{
			var D:Date = new Date();
			return D.hours;
		}
		public static function get Min():int
		{
			var D:Date = new Date();
			return D.minutes;
		}
		public static function get Sec():int
		{
			var D:Date = new Date();
			return D.seconds;
		}
		
		public static function get YYYYMMDDHHMMSS():String
		{
			var Y:int = Year;
			var Month:int = Month;
			var D:int = Day;
			var H:int = Hour;
			var M:int = Min;
			var S:int = Sec;
			
			var R:String = Y + "" + (Month < 10 ? "0" + Month: ""+Month) + 
				(D < 10 ? "0" + D: ""+D) +
				(H < 10 ? "0" + H: ""+H) +
				(M < 10 ? "0" + M: ""+M) +
				(S < 10 ? "0" + S: ""+S);
			return R;
		}
	}
}