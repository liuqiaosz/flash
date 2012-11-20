package pixel.assets
{
	import pixel.core.PixelNs;

	use namespace PixelNs;
	
	public class PixelAssetsManager
	{
		private static var _instance:IPixelAssetsManager = null;
		public function PixelAssetsManager()
		{
		}
		
		public static function get instance():IPixelAssetsManager
		{
			if(null == _instance)
			{
				_instance = new PixelAssetsManagerImpl();
			}
			return _instance;
		}
	}
}
import pixel.assets.IPixelAssetsManager;
import pixel.assets.IPixelAssetsMarshal;
import pixel.assets.PixelAssetTask;
import pixel.assets.PixelDefaultAssetLoader;
import pixel.assets.event.PixelAssetEvent;

/**
 * 资源管理器接口
 * 
 * 
 * 
 **/
class PixelAssetsManagerImpl implements IPixelAssetsManager
{
	private var _loader:IPixelAssetsMarshal = null;
	/**
	 *
	 * 资源管理器
	 * 
	 * @param	customerLoader		自定义加载器，允许通过PixelWorker类库封装的多线程加载器
	 */
	public function PixelAssetsManagerImpl(customerLoader:Class = null)
	{
		if(null == customerLoader)
		{
			customerLoader = PixelDefaultAssetLoader;
		}
		
		_loader = new customerLoader() as IPixelAssetsMarshal;
	}
	
	public function get loader():IPixelAssetsMarshal
	{
		return _loader;
	}
	
	/**
	 * 变更加载器
	 * 
	 * @param	handler		自定义加载器
	 * 
	 * 
	 */
	public function changeHandler(handler:Class):void
	{
		if(_loader)
		{
			_loader.stop();
			//停止当前下载器
		}
		var queue:Vector.<PixelAssetTask> = _loader.getQueue();
		var cache:Vector.<PixelAssetTask> = _loader.getCacheArray();
		
		_loader = new handler() as IPixelAssetsMarshal;
		_loader.margeCache(cache);
		
		//将未完成的任务重新加入新下载器的任务队列
		for each(var task:PixelAssetTask in queue)
		{
			_loader.pushTaskToQueue(task);
		}
	}
}
