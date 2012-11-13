package pixel.core
{

	use namespace PixelNs;
	/**
	 * 
	 * 模块管理单例
	 * 
	 * 
	 **/
	public class PixelModuleManager
	{
		private static var _instance:IPixeloduleManager = null;
		
		public function PixelModuleManager()
		{
		}
		
		PixelNs static function initializer():void
		{
			if(!_instance)
			{
				_instance = new ModuleManagerImpl();
			}
		}
		public static function get instance():IPixeloduleManager
		{
			return _instance;
		}
	}
}
import pixel.core.IPixeloduleManager;

/**
 * 模块管理实现类
 * 
 * 
 * 
 **/
class ModuleManagerImpl implements IPixeloduleManager
{
	public function ModuleManagerImpl()
	{
		
	}
}