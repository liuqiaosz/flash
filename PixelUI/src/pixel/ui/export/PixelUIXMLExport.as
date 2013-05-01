package pixel.ui.export
{
	import flash.utils.ByteArray;
	
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	
	/**
	 * 
	 * <ui>
	 * 	<styles>
	 * 		<style id="">
	 * 		</style>
	 * 	<styles>
	 * 	
	 * 	<controls>
	 * 		<control id="" type="">
	 * 			<style link="">
	 * 			<style>
	 * 
	 * 			<children>
	 * 			</children>
	 * 		</control>
	 * 	<controls>
	 * </ui>
	 * 
	 * 
	 * 
	 * 
	 **/
	/**
	 * UI组件XML格式数据导出
	 * 
	 **/
	public class PixelUIXMLExport implements IPixelUIExport
	{
		public function PixelUIXMLExport()
		{
		}
		
		public function encode(control:IUIControl):ByteArray
		{
			var data:ByteArray = new ByteArray();
			if(control is UIControl)
			{
				data.writeBytes(controlNodeEncode(control as UIControl));
			}
			else if(control is UIContainer)
			{
				data.writeBytes(containerNodeEncode(control as UIContainer));
			}
			return data;
		}
		
		private function controlNodeEncode(contro:UIControl):ByteArray
		{
			return null;
		}
		
		private function containerNodeEncode(container:UIContainer):ByteArray
		{
			return null;
		}
	}
}