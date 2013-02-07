package bleach.message
{
	public class BleachPopUpMessage extends BleachMessage
	{
		public static const BLEACH_POPUP_SHOW:String = "PopUpShow";
		public static const BLEACH_POPUP_CLOSE:String = "PopUpClose";
		
		private var _isCenter:Boolean = true;
		public function set isCenter(value:Boolean):void
		{
			_isCenter = value;
		}
		public function get isCenter():Boolean
		{
			return _isCenter;
		}
		private var _isModel:Boolean = true;
		public function set isModel(value:Boolean):void
		{
			_isModel = value;
		}
		public function get isModel():Boolean
		{
			return _isModel;
		}
		public function BleachPopUpMessage(msg:String)
		{
			super(msg);
		}
	}
}