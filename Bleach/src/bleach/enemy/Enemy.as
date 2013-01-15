package bleach.enemy
{
	import pixel.codec.spr.ISpriteSheet;
	import pixel.core.PixelSprite;
	import pixel.core.PixelSpriteSheet;
	
	/**
	 * 单位基类
	 * 
	 * 基于序列动画渲染模式
	 **/
	public class Enemy extends PixelSpriteSheet implements IEnemy
	{
		public function Enemy(sheet:ISpriteSheet)
		{
			super(sheet);
		}
	}
}