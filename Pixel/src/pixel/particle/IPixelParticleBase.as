package pixel.particle
{
	import pixel.core.IPixel;

	public interface IPixelParticleBase extends IPixel
	{
		function reset():void;
		//更新粒子生命状态
		//function updateHealth(attenuation:Number = 0):Number;
		
		function set x(value:Number):void;
		function set y(value:Number):void;
		
		function get redian():Number;
		function get isDeath():Boolean;
	}
}