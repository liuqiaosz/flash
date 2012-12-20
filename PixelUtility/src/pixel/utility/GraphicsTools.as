package pixel.utility
{
	import flash.display.Graphics;

	public class GraphicsTools
	{
		
		/**
		 * 绘制扇形 
		 * @param graphics 绘图对象
		 * @param x 圆心x轴
		 * @param y 圆心vy轴
		 * @param radius 半径
		 * @param size 绘制的扇形大小（角度制，0<=size<=360)
		 * @param startRotation 开始的角度(角度制，默认为270度即12点方向)
		 * 
		 */                
		private static function drawSector(graphics:Graphics,x:int,y:int,radius:int,size:Number,startRotation:Number=270):void
		{
			
			
			if(size<=0) return;
			if(size > 360) size = 360;
			
			var n:int=8;
			size = Math.PI/180 * size;
			var angleN:Number = size/n;
			//绘制二次贝塞尔曲线的外切半径
			var tangentRadius:Number = radius/Math.cos(angleN/2);
			//转换为弧度
			var angle:Number=startRotation* Math.PI / 180;
			
			var cx:Number;
			var cy:Number;
			var ax:Number;
			var ay:Number;
			
			//开始角度再圆上的位置
			var startX:Number = x + Math.cos(angle) * radius;
			var startY:Number = y + Math.sin(angle) * radius;
			
			graphics.moveTo(startX, startY);
			//graphics.lineTo(startX, startY);
			for (var i:Number = 0; i < n; i++) {
				
				//绘制2次贝塞尔曲线，
				angle += angleN;
				//求出开始点与将要绘制点的角平分线与将要绘制点的交点
				cx = x + Math.cos(angle-(angleN/2))*(tangentRadius);
				cy = y + Math.sin(angle-(angleN/2))*(tangentRadius);
				//僬侥绘制点在圆上的位置
				ax = x + Math.cos(angle) * radius;
				ay = y + Math.sin(angle) * radius;
				
				graphics.curveTo(cx, cy, ax, ay);
			}
			graphics.lineTo(x, y);
			
		}
	}
}