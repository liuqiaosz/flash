package mapassistant.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mapassistant.resource.ResourceItem;
	import mapassistant.util.Tools;
	
	import mx.core.UIComponent;
	import mx.graphics.SolidColorStroke;
	
	import org.osmf.elements.SWFElement;
	
	import spark.components.BorderContainer;
	import spark.components.Form;
	import spark.components.FormItem;
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalAlign;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalAlign;
	import spark.layouts.VerticalLayout;
	
	import utility.BitmapTools;
	import utility.swf.event.SWFEvent;
	import utility.swf.tag.GenericTag;
	import utility.swf.tag.Tag;

	public class ResourceLibraryItem extends BorderContainer
	{
		private var _Tag:GenericTag = null;
		private var Image:Group = null;
		private var Desc:Form = null;
		private var Stroke:SolidColorStroke = null;
		private var _PreviewImage:FlexImage = null;
		private var _OrignalImage:FlexImage = null;
		public function ResourceLibraryItem(AssetTag:GenericTag)
		{
			super();
			
			Initialize();
			_Tag = AssetTag;
			
			Stroke = new SolidColorStroke(0x000000,1);
			borderStroke = Stroke;
			
//			var VerLayout:VerticalLayout = new VerticalLayout();
//			VerLayout.horizontalAlign = HorizontalAlign.CENTER;
//			layout = VerLayout;
			switch(_Tag.Type)
			{
				case Tag.LOSSLESS2:
					AddBitmap(Bitmap(_Tag.Source));
					
					break;
				case Tag.DEFINEJPEG2:
					if(_Tag.Source)
					{
						AddBitmap(Bitmap(_Tag.Source));
					}
					else
					{
						_Tag.addEventListener(SWFEvent.ASYNCLOAD_COMPLETE,OnJpegLoaded);
					}
					
					break;
			}
			
			this.buttonMode = true;
		}
		
		private function OnJpegLoaded(event:SWFEvent):void
		{
			AddBitmap(Bitmap(_Tag.Source));
			_Tag.removeEventListener(SWFEvent.ASYNCLOAD_COMPLETE,OnJpegLoaded);
		}
		
		protected function AddBitmap(Source:Bitmap):void
		{
			var ImgData:BitmapData = BitmapTools.BitmapClone(Source.bitmapData);
			//var Img:Bitmap = new Bitmap(ImgData);
			
			//原始图形
			_OrignalImage = new FlexImage(new Bitmap(ImgData));
			//			var Scale:Number = ImgData.width > ImgData.height ? 
			//				(ImgData.width > 48 ? 48 /ImgData.width : 1) : 
			//				(ImgData.height > 48 ? 48 /ImgData.height : 1);
			
			var PreviewData:BitmapData = Tools.BitmapScale(ImgData,45);
			var Img:Bitmap = new Bitmap(PreviewData);
			//Img.scaleX = Scale;
			//Img.scaleY = Scale;
			//缩略图
			_PreviewImage = new FlexImage(Img);
			Image.addElement(_PreviewImage);
		}
		
		public function get PreviewImage():FlexImage
		{
			return _PreviewImage;
		}
		public function get OrignalImage():FlexImage
		{
			return _OrignalImage;
		}
		
		public function get ResourceId():String
		{
			return _Tag.Id;
		}
		/**
		 * 
		 * 初始化
		 * 
		 **/
		private function Initialize():void
		{
			width = 58;
			height = 58;
			
			//var Content:Group = new Group();
			//Content.layout = new TileLayout();
			
			//spark.layouts.TileLayout(Content.layout).paddingTop = 5;
			//spark.layouts.TileLayout(Content.layout).paddingLeft = 5;
			
			//Content.percentHeight = 100;
			//Content.percentWidth = 100;
		    
			//addElement(Content);
			this.layout = new TileLayout();
			spark.layouts.TileLayout(layout).paddingTop = 5;
			spark.layouts.TileLayout(layout).paddingLeft = 5;
			Image = new Group();
			Image.width = 48;
			Image.height = 48;
			addElement(Image);
		}
		
		
	}
	
}
import mx.graphics.SolidColor;
import mx.graphics.SolidColorStroke;

import spark.components.supportClasses.Skin;
import spark.primitives.Rect;

class BorderSkin extends Skin
{
	public function BorderSkin()
	{
		var Rectangle:Rect = new Rect();
		Rectangle.radiusX = 10;
		Rectangle.radiusY = 10;
		
		Rectangle.stroke = new SolidColorStroke(0xff0000);
		
		Rectangle.fill = new SolidColor(0xffffff);
		this.addElement(Rectangle);
	}
}