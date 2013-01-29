package pixel.particle
{
	import pixel.utility.IUpdate;

	public interface IPixelParticleBase extends IUpdate
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