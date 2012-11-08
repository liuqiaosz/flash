package mapassistant.assetblock
{
	import editor.uitility.ui.FlexBitmap;
	
	import flash.display.Bitmap;

	/**
	 * 
	 * 图块数据
	 * 
	 **/
	public class AssetBlock
	{
		private var _Name:String = "";
		public function set Name(Value:String):void
		{
			_Name = Value;
		}
		public function get Name():String
		{
			return _Name;
		}
		//图形映射类型 0： SWF资源库 1:本地图片文件映射
		private var _ImageReference:int = 0;
		public function set ImageReference(Value:int):void
		{
			_ImageReference = Value;
		}
		public function get ImageReference():int
		{
			return _ImageReference;
		}
		//图形ID 如果映射类型为0时该值为Class
		private var _ImageId:String = "";
		public function set ImageId(Value:String):void
		{
			_ImageId = Value;
		}
		public function get ImageId():String
		{
			return _ImageId;
		}
		
		//最小单位的宽和高
		private var _UnitWidth:int = 0;
		public function set UnitWidth(Value:int):void
		{
			_UnitWidth = Value;
		}
		public function get UnitWidth():int
		{
			return _UnitWidth;
		}
		private var _UnitHeight:int = 0;
		public function set UnitHeight(Value:int):void
		{
			_UnitHeight = Value;
		}
		public function get UnitHeight():int
		{
			return _UnitHeight;
		}
		
		//图形偏移
		private var _OffsetX:int = 0;
		public function set OffsetX(Value:int):void
		{
			_OffsetX = Value;
		}
		public function get OffsetX():int
		{
			return _OffsetX;
		}
		
		private var _OffsetY:int = 0;
		public function set OffsetY(Value:int):void
		{
			_OffsetY = Value;
		}
		public function get OffsetY():int
		{
			return _OffsetY;
		}
		
		private var _Image:Bitmap = null;
		public function set Image(Value:Bitmap):void
		{
			_Image = Value;
		}
		public function get Image():Bitmap
		{
			return _Image;
		}
		
//		private var _CutArray:Vector.<FlexBitmap> = new Vector.<FlexBitmap>();
//		public function get ImageCutArray():Vector.<FlexBitmap>
//		{
//			return _CutArray;
//		}
//		
		public function AssetBlock()
		{
			
		}
	}
}