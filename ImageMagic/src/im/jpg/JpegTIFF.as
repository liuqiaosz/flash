package im.jpg
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	
	public class JpegTIFF
	{
		public static const IDF_ID:int = 0x010E;
		public static const IDF_MODEL:int = 0x0110;
		public static const IDF_MAKE:int = 0x010F;
		public static const IDF_ORIENT:int = 0x0112;
		public static const IDF_RESX:int = 0x011A;
		public static const IDF_RESY:int = 0x011B;
		public static const IDF_RES:int = 0x0128;
		public static const IDF_SOFT:int = 0x0131;
		public static const IDF_DT:int = 0x0132;
		public static const IDF_WP:int = 0x013E;
		public static const IDF_PC:int = 0x013F;
		public static const IDF_YCBC:int = 0x0211;
		public static const IDF_YBDP:int = 0x0213;
		public static const IDF_RB:int = 0x0214;
		public static const IDF_COPY:int = 0x8298;
		public static const IDF_SUBOFFSET:int = 0x8769;
		/**
		 * x010eImageDescription（图像描述）ascii string描述相片，不支持双字节的字符，如汉语、韩语、日语
0x010fMake（制造商）ascii string数码相机制造商。在Exif标准中是可选的，但在DCF（数码相机格式）中是必需的。
0x0110Model（型号）ascii string数码相机型号。在Exif标准中是可选的，但在DCF（数码相机格式）中是必需的。
0x0112Orientation（方向）unsigned short
0x011aXresolution（水平分辨率）unsigned rational1
图像显示、打印的分辨率。默认值值是每英寸72像素，但是因为个人计算机不使用这个值来显示或者打印，所以这个值没有意义。
0x011bYresolution（垂直分辨率）unsigned rational1
0x0128ResolutionUnit（分辨率单位）unsigned short1
水平或者垂直分辨率XResolution(0x011a)/YResolution(0x011b)的单位，'1''表示没有单位，'2'表示英寸，'3'表示厘米。默认为'2'。
0x0131Software（软件）ascii string
Shows firmware(internal software of digicam) version number.固件（数码相机内软件）版本号。
0x0132DateTime（日期时间）ascii string20图像最后修改的日期时间。日期格式为"YYYY:MM:DD HH:MM:SS" + 0x00，一共20字节。如果没有设置时钟或者数码相机没有时钟，这个区域可填充空格。通常，这个标签的值与DateTimeOriginal(0x9003)的值相同。
0x013eWhitePoint（白点）unsigned rational2定义了图像白点的色度。如果图像使用CIE（国际照明委员会）标准亮度D65（被认为是‘阳光’的标准）的光源，这个值为'3127/10000,3290/10000'。
0x013fPrimaryChromaticities（原色色度）unsigned rational6定义了原色的色度。如果图像使用CCIR推荐709原色方案，这个值应该为'640/1000,330/1000,300/1000,600/1000,150/1000,0/1000'。
0x0211YcbCrCoefficients（颜色空间转换矩阵系数）unsigned rational3当图像格式为YcbCr时，这个值包含一个与RGB格式转换的常量参数。通常，这个值为'0.299/0.587/0.114'。
0x0213YcbCrPositioning（YcbCr配置）unsigned short1When image format is YCbCr and uses 'Subsampling'(cropping of chroma data, all the digicam do that), defines the chroma sample point of subsampling pixel array. '1' means the center of pixel array, '2' means the datum point.
当图像格式为YCbCr且使用部分采样（色度数据的取样，所有数码相机都会这么做）时，定义了部分抽样像素数组的色度样本点。'1'表示像素数组的中间，'2'表示基准点。
0x0214ReferenceBlackWhite（黑白参照值对）unsigned rational6Shows reference value of black point/white point. In case of YCbCr format, first 2 show black/white of Y, next 2 are Cb, last 2 are Cr. In case of RGB format, first 2 show black/white of R, next 2 are G, last 2 are B.
黑白点参照值。在YcbCr格式的方案中，头2字节表示Y的黑白参照值，接下来的2字节是Cb的，最后2字节是Cr的。在RGB格式方案中，头2字节表示R的黑白参照值，接下来的2字节是G的，最后2字节是B的。
0x8298Copyright(版权)ascii stringShows copyright information
版权信息
0x8769ExifOffsetunsigned long1
Offset to Exif Sub IFD
子IFD的偏移量
		 **/
		private var _endian:String = "";
		private var _ifd:int = 0;
		private var _entityCount:int = 0;
		public function JpegTIFF(data:ByteArray)
		{
			var _oldEndian = data.endian;
			_endian = data.readUTFBytes(2);
			if(_endian == "MM")
			{
				data.endian = Endian.BIG_ENDIAN;
			}
			else if(_endian == "II")
			{
				data.endian = Endian.LITTLE_ENDIAN;
			}
			data.readShort();
			_ifd = data.readInt();
			
			idfDecode(data);
			data.endian = _oldEndian;
		}
		
		private function idfDecode(data:ByteArray):void
		{
			_entityCount = data.readShort();
			
			for(var idx:int = 0; idx<_entityCount; idx++)
			{
				idfEntityDecode(data);
			}
			trace(data.position);
		}
		
		private function idfEntityDecode(data:ByteArray):void
		{
			var tag:int = data.readUnsignedShort();
			var format:int = data.readShort();
			var elementCount:int = data.readUnsignedInt();
			var value:int = data.readUnsignedInt();
			//trace(data.readUTFBytes(8));
			
			trace("Tag[" + tag.toString(16) + "] format[" + format + "] count[" + elementCount + "] value[" + value +"]");
		} 
	}
}