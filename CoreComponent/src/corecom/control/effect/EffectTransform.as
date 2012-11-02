package corecom.control.effect
{
	import flash.geom.Point;

	/**
	 * 变换效果
	 * 
	 * 
	 **/
	public class EffectTransform  extends Effect  implements IEffect
	{
		private var _Move:Boolean = false;
		private var _Scale:Boolean = false;
		private var _Rotate:Boolean = false;
		
		private var _MovePosition:Point = null;
		public function Move(PosX:int,PosY:int):void
		{
			_Move = true;
			if(null == _MovePosition)
			{
				_MovePosition = new Point();
			}
			_MovePosition.x = PosX;
			_MovePosition.y = PosY;
		}
		
		private var _ScaleX:Number = 0;
		private var _ScaleY:Number = 0;
		public function Scale(X:Number,Y:Number):void
		{
			_Scale = true;
			_ScaleX = X;
			_ScaleY = Y;
		}
		private var _Angle:Number = 0;
		public function Rotate(Angle:Number):void
		{
			_Rotate = true;
			_Angle = Angle;
		}
		
		public function EffectTransform(Source:Object)
		{
			super(Source);
		}
		
		override public function BuildParams():Object
		{
			var Param:Object = super.BuildParams();
			if(_Move)
			{
				Param.x = _MovePosition.x;
				Param.y = _MovePosition.y;
			}
			if(_Scale)
			{
				Param.scaleX = _ScaleX;
				Param.scaleY = _ScaleY;
			}
			if(_Angle)
			{
				Param.rotation = _Angle;
			}
			return Param;
		}
	}
}