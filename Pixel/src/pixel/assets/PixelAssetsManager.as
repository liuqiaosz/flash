package pixel.assets
{
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	public class PixelAssetsManager
	{
		public function PixelAssetsManager()
		{
		}
	}
}
import pixel.assets.IAssetsLoader;
import pixel.assets.IPixelAssetsManager;

/**
 * 资源管理器接口
 * 
 * 
 * 
 **/
class PixelAssetsManagerImpl implements IPixelAssetsManager
{
	private var _loader:IAssetsLoader = null;
	/**
	 *
	 * 资源管理器
	 * 
	 * @param	customerLoader		自定义加载器，允许通过PixelWorker类库封装的多线程加载器
	 */
	public function PixelAssetsManagerImpl(customerLoader:Class = null)
	{
		if(customerLoader)
		{
			_loader
		}
	}
}
