package bleach.view
{
	import bleach.scene.vo.WorldVO;

	public interface IWorldViewController extends IViewController
	{
		function changeWorld(world:WorldVO):void;
	}
}