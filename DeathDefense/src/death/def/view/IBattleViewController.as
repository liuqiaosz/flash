package death.def.view
{
	import death.def.scene.vo.BattleVO;

	public interface IBattleViewController
	{
		//开始战斗
		function fightBegin(vo:BattleVO):void;
		//显示结算界面
		function showScore():void;
	}
}