package death.def.module.message.vo
{
	public class MSGLevel
	{
		private var _levelIdx:int = 0;
		public function set levelIdx(value:int):void
		{
			_levelIdx = value;
		}
		public function get levelIdx():int	
		{
			return _levelIdx;
		}
		private var _levelName:String = "";
		public function set levelName(value:String):void
		{
			_levelName = value;
		}
		private var _levelDesc:String = "";
		private var _levelBackgroundImgId:String = "";
		private var _available:Boolean = false;
		private var _hightScore:int = 0;
		private var _complete:Boolean = false;
		
		public function MSGLevel()
		{
		}
	}
}