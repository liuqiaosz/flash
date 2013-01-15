package bleach.scene.ui
{
	import flash.display.Bitmap;
	
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIImage;
	import pixel.utility.BitmapTools;
	import pixel.utility.Tools;
	
	/**
	 * Flow 节点UI定义
	 **/
	public class WorldFlowItem extends UIContainer
	{
		public function WorldFlowItem(itemWidth:Number = 0,itemHeight:Number = 0)
		{
			super();
			this.LeftBottomCorner = this.LeftTopCorner = this.RightBottomCorner = this.RightTopCorner = 5;
			this.Layout = LayoutConstant.VERTICAL;
			this.Gap = this.padding = 5;
			if(itemWidth > 0)
			{
				width = itemWidth;
			}
			if(itemHeight > 0)
			{
				height = itemHeight;
			}
		}
		
		public function set image(value:Bitmap):void
		{
			_image.BackgroundImage = value;
		}
		
		private var _image:UIImage = null;
		private var _infoBar:InfoBar = null;
		
		/**
		 * 初始化
		 * 
		 **/
		override public function initializer():void
		{
			super.initializer();
			_image = new UIImage();
			addChild(_image);
			_infoBar = new InfoBar();
			addChild(_infoBar);
		}
	}
}

import pixel.ui.control.UIContainer;
class InfoBar extends UIContainer
{
	public function InfoBar()
	{
		super();
	}
}