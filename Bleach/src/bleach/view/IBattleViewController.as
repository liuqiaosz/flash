package bleach.view
{
	import bleach.scene.vo.BattleVO;

	public interface IBattleViewController
	{
		//开始战斗
		function fightBegin(vo:BattleVO):void;
		//显示结算界面
		function showScore():void;
	}
}