package pixel.graphic
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import pixel.core.IPixelNode;
	import pixel.core.IPixelSprite;
	import pixel.core.PixelLauncher;
	import pixel.core.PixelModule;
	import pixel.core.PixelNs;
	import pixel.scene.IPixelScene;
	
	use namespace PixelNs;

	/**
	 * 绘图封装模块
	 * 
	 * 该模块只支持场景的全位图渲染
	 * 
	 * 
	 **/
	public class PixelGraphicModule extends PixelModule implements IPixelGraphicModule
	{
		private var _screen:Stage = null;
		public function PixelGraphicModule()
		{
			super();
		}
		
		/**
		 * 初始化
		 * 
		 * 
		 **/
		override protected function initializer():void
		{
			super.initializer();
			//获取当前主舞台
			_screen = PixelLauncher.launcher.stage;
			
		}
		
		//画布
		protected var _gameCanvas:Bitmap = null;
		protected var _gameClip:BitmapData = null;
		protected var _renderNodes:Vector.<IPixelNode> = null;
		protected var _scene:IPixelScene = null;
		protected var _node:IPixelSprite = null;
		protected var _nodeClip:BitmapData = null;
		protected var _drawDest:Point = new Point();
		
		/**
		 * 根据当前的渲染模式选择渲染方式（目前只开放位图渲染）
		 * 
		 * @param	scenes		当前要进行渲染的场景（允许多个场景同时渲染，多个场景同时渲染出现在场景切换过程中）
		 * 
		 **/
		public function render(scenes:Vector.<IPixelScene>):void
		{
			for each(_scene in scenes)
			{
				if(!_gameCanvas)
				{
					_gameClip = new BitmapData(_screen.stageWidth,_screen.stageHeight);
					_gameCanvas = new Bitmap();
					_gameCanvas.bitmapData = _gameClip;
					_screen.addChild(_gameCanvas);
				}
				_gameClip.fillRect(_gameClip.rect,0xFF000000);
				
				/**
				 * 绘制到画布的位置，场景偏移+当前精灵偏移
				 * 正常情况下场景偏移为0，所以实际绘制的精灵位置与精灵的实际位置相同
				 * 场景切换过程中场景的偏移会发生改变，这个时候超出屏幕部分的精灵则不予以绘制
				 **/
				_renderNodes = _scene.nodes;
				for each(_node in _renderNodes)
				{
					_nodeClip = _node.image;
					if(_nodeClip)
					{
						if(_drawDest.x < 0 || _drawDest.x + _nodeClip.width > _gameClip.width || 
							_drawDest.y < 0 || _drawDest.y + _nodeClip.height > _gameClip.height)
						{
							//超出边界不做处理
							continue;
						}
						_gameClip.copyPixels(_nodeClip,_nodeClip.rect,_drawDest);
					}
				}
			}
		}
//		public function render(scene:IPixelScene,hotRender:Boolean = false):void
//		{
//			if(!hotRender)
//			{
//				//重绘整屏，清空画布
//				_gameClip.fillRect(_gameClip.rect,0);
//			}
//			//获取需要渲染的节点
//			_renderNodes = scene.renderNodes;
//			for each(_node in _renderNodes)
//			{
//				_nodeClip = _node.clip;
//				if(_nodeClip)
//				{
//					_drawDest.x = _node.x;
//					_drawDest.y = _node.y;
//					_gameClip.copyPixels(_nodeClip,_nodeClip.rect,_drawDest);
//				}
//			}
//			_nodeClip.clone()
//		}
	}
}