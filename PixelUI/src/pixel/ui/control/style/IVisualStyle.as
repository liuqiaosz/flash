package pixel.ui.control.style
{
	import flash.display.Bitmap;
	
	import pixel.utility.IDispose;

	public interface IVisualStyle extends IStyle,IBackgroundStyle,IDispose
	{
		//边框
		function set BorderThinkness(Value:int):void;
		function get BorderThinkness():int;
		
		//边框颜色
		function set BorderColor(Value:uint):void;
		function get BorderColor():uint;
		
		//边框透明度
		function set BorderAlpha(Value:Number):void;
		function get BorderAlpha():Number;
		
		//边框圆角
		//		function set BorderCorner(Value:int):void;
		//		function get BorderCorner():int;
		
		function set LeftTopCorner(Value:int):void;
		function set LeftBottomCorner(Value:int):void;
		function set RightTopCorner(Value:int):void;
		function set RightBottomCorner(Value:int):void;
		
		function get LeftTopCorner():int;
		function get LeftBottomCorner():int;
		function get RightTopCorner():int;
		function get RightBottomCorner():int;
		
		
		
//		function set Width(Value:Number):void;
//		function get Width():Number;
//		
//		function set Height(Value:Number):void;
//		function get Height():Number;
		
		function get Shape():uint;
		function set Shape(Value:uint):void;
		
		function set Radius(Value:int):void;
		function get Radius():int;
		
		//Scale9Grid状态设置
		function set Scale9Grid(Value:Boolean):void;
		function get Scale9Grid():Boolean;
		
		//Scale9Grid 参数设置
		function set Scale9GridLeft(Value:int):void;
		function get Scale9GridLeft():int;
		function set Scale9GridRight(Value:int):void;
		function get Scale9GridRight():int;
		function set Scale9GridTop(Value:int):void;
		function get Scale9GridTop():int;
		function set Scale9GridBottom(Value:int):void;
		function get Scale9GridBottom():int;
		
		function get FontTextStyle():FontStyle;
		
		function set ImagePack(Value:Boolean):void;
		function get ImagePack():Boolean;
		
		function get HaveImage():Boolean;
	}
}