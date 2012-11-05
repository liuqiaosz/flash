package ui
{
import corecom.control.*;
 import corecom.control.asset.ControlAssetManager;

 import flash.display.Bitmap;
import flash.display.BitmapData; 
import corecom.control.style.ContainerStyle; 
public class c2 extends corecom.control.UIPanel
{
public var Component_0:ui.c1 = new ui.c1();

public function c2()
{
addChild(Component_0);
Component_0.x = 99;
Component_0.y = 71;

this.width=500;
this.height=500;
Component_0.ButtonOne.LeftTopCorner=30;
Component_0.ButtonTwo.RightTopCorner=30;
Component_0.SliderScroll.RightTopCorner=30;

}
}
}
