package death.def.scene.vo
{
	import death.def.enemy.IEnemy;

	/**
	 * 回合数据VO
	 **/
	public class BattleRoundVO
	{
		//单位队列
		private var _units:Vector.<IEnemy> = null;
		public function BattleRoundVO()
		{
			_units = new Vector.<Vector.<IEnemy>>();
		}
		
		public function set units(value:Vector.<IEnemy>):void
		{
			_units = value;
		}
		public function get units():Vector.<IEnemy>
		{
			return _units;
		}
	}
}