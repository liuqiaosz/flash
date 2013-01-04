package death.def.view
{
	import death.def.scene.vo.WorldVO;

	public interface IWorldViewController extends IViewController
	{
		function changeWorld(world:WorldVO):void;
	}
}