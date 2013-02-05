package bleach
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class Debuger extends Sprite
	{
		private var _infoArea:TextField = null;
		public function Debuger()
		{
			_infoArea = new TextField();
			_infoArea.width = 300;
			_infoArea.height = 100;
			_infoArea.border = true;
			_infoArea.multiline = true;
			_infoArea.backgroundColor = 0xffffff;
			_infoArea.background = true;
			
			addChild(_infoArea);
		}
		
		public function log(txt:String):void
		{
			_infoArea.appendText(txt + "\n");
			_infoArea.scrollV = _infoArea.maxScrollV;
		}
	}
}