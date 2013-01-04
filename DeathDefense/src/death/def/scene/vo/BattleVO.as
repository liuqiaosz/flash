package death.def.scene.vo
{
	public class BattleVO
	{
		//Battle id
		private var _id:int = 0;
		
		private var _rounds:Vector.<BattleRoundVO> = null;
		public function BattleVO()
		{
			_rounds = new Vector.<BattleRoundVO>();
		}
	}
}