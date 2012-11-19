package ui
{
import corecom.control.*;
 import pixel.ui.control.asset.ControlAssetManager;

 import flash.display.Bitmap;
import flash.display.BitmapData; 
import pixel.ui.control.style.ContainerStyle; 
public class c1 extends pixel.ui.control.UIPanel
{
public var Child_0:UISlider = new UISlider();
public var Child_1:UIButton = new UIButton();
public var Child_2:UIButton = new UIButton();

public function c1()
{
addChild(Child_0);
Child_0.x = 42;
Child_0.y = 36;
addChild(Child_1);
Child_1.x = 7;
Child_1.y = 173;
addChild(Child_2);
Child_2.x = 136;
Child_2.y = 171;

this.width=250;
this.height=250;
Child_0.width=150;
Child_0.height=40;
Child_0.Style.BackgroundAlpha=0;
Child_0.Style.BorderThinkness=0;
Child_1.width=100;
Child_1.height=40;
Child_1.MouseOverStyle.Width=100;
Child_1.MouseOverStyle.Height=40;
Child_1.MouseDownStyle.Width=100;
Child_1.MouseDownStyle.Height=40;
Child_2.width=100;
Child_2.height=40;
Child_2.MouseOverStyle.Width=100;
Child_2.MouseOverStyle.Height=40;
Child_2.MouseDownStyle.Width=100;
Child_2.MouseDownStyle.Height=40;

}
}
}
