package pixel.core
{
	import pixel.graphic.PixelRenderMode;

	public class PixelConfig
	{
		//渲染模式,默认显示列表
		private static var _renderMode:int = PixelRenderMode.RENDER_NORMAL;
		public static function set renderMode(value:int):void
		{
			_renderMode = value;
		}
		public static function get renderMode():int
		{
			return _renderMode;
		}
	}
}