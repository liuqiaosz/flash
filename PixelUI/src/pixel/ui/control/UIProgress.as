package pixel.ui.control
{
	import flash.display.Graphics;
	
	import pixel.ui.control.asset.AssetImage;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIProgressStyle;

	public class UIProgress extends UIControl
	{
		
		public function set barColor(value:uint):void
		{
			UIProgressStyle(_Style).barColor = value;
			Update();
		}
		public function get barColor():uint
		{
			return UIProgressStyle(_Style).barColor;
		}
		
		public function set barAlpha(value:Number):void
		{
			UIProgressStyle(_Style).barAlpha = value;
			Update();
		}
		public function get barAlpha():Number
		{
			return UIProgressStyle(_Style).barAlpha;
		}
		public function UIProgress(skin:Class = null)
		{
			super(skin ? skin:UIProgressStyle);
			width = 150;
			height = 20;
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			_percentWidth = width * 0.5;
		}
		
		override protected function StyleRender(Style:IVisualStyle):void
		{
			var style:UIProgressStyle = Style as UIProgressStyle;
			var pen:Graphics = this.graphics;
			pen.clear();
			
			if(style.BorderThinkness > 0)
			{
				pen.lineStyle(style.BorderThinkness,style.BorderColor,style.BorderAlpha);
			}
			pen.beginFill(style.BackgroundColor,style.BackgroundAlpha);
			if(style.HaveImage)
			{
				if(style.BackgroundImage != null)
				{
					bitmapRender();
				}
				else
				{
					if(!style.ImagePack)
					{
						var asset:AssetImage = PixelAssetManager.instance.FindAssetById(style.BackgroundImageId) as AssetImage;
						if(asset)
						{
							//资源已经欲载
							BackgroundImage = asset.image;
							bitmapRender();
						}
						else
						{
							//注册资源加载通知
							PixelAssetManager.instance.AssetHookRegister(style.BackgroundImageId,this);
						}
					}
				}
				
			}
			else
			{
				graphics.beginFill(Style.BackgroundColor,Style.BackgroundAlpha);
			}
			
			if(style.LeftBottomCorner > 0 || style.LeftTopCorner > 0 || style.RightTopCorner > 0 || style.RightBottomCorner > 0)
			{
				//graphics.drawRoundRectComplex(0,0,Style.Width,Style.Height,Style.LeftTopCorner,Style.RightTopCorner,Style.LeftBottomCorner,Style.RightBottomCorner);
				graphics.drawRoundRectComplex(0,0,_ActualWidth,_ActualHeight,style.LeftTopCorner,style.RightTopCorner,style.LeftBottomCorner,style.RightBottomCorner);
			}
			else
			{
				graphics.drawRect(0,0,_ActualWidth,_ActualHeight);
				//graphics.drawRect(0,0,Style.Width,Style.Height);
			}
			
			pen.endFill();
			pen.beginFill(style.barColor,style.barAlpha);
			if(style.LeftBottomCorner > 0 || style.LeftTopCorner > 0 || style.RightTopCorner > 0 || style.RightBottomCorner > 0)
			{
				//graphics.drawRoundRectComplex(0,0,Style.Width,Style.Height,Style.LeftTopCorner,Style.RightTopCorner,Style.LeftBottomCorner,Style.RightBottomCorner);
				graphics.drawRoundRectComplex(0,0,_percentWidth,_ActualHeight,style.LeftTopCorner,style.RightTopCorner,style.LeftBottomCorner,style.RightBottomCorner);
			}
			else
			{
				graphics.drawRect(0,0,_percentWidth,_ActualHeight);
				//graphics.drawRect(0,0,Style.Width,Style.Height);
			}
			pen.endFill();
		}
		
		private var _percentWidth:Number = 0;
		private var _total:Number = 0;
		private var _value:Number = 0;
		public function progressUpdate(total:Number,value:Number):void
		{
			_total = total;
			_value = value;
			
			_percentWidth = (_value / _total) * width;
			Update();
		}
	}
}