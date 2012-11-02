package ui
{
import corecom.control.*;
 import corecom.control.asset.ControlAssetManager;

 import flash.display.Bitmap;
import flash.display.BitmapData; 
import corecom.control.style.ContainerStyle; 
public class aa extends corecom.control.SimplePanel
{
public var Component_0:ui.c1 = new ui.c1();
public var Child_0:SimpleTabPanel = new SimpleTabPanel();
public var Child_1:SimpleSlider = new SimpleSlider();
public var Child_2:SimpleButton = new SimpleButton();

public function aa()
{
addChild(Component_0);
Component_0.x = 85;
Component_0.y = 42;
addChild(Child_0);
Child_0.x = 33;
Child_0.y = 365;
addChild(Child_1);
Child_1.x = 309;
Child_1.y = 405;
addChild(Child_2);
Child_2.x = 374;
Child_2.y = 184;

this.width=500;
this.height=500;
Component_0.Child_0.SliderLineColor=52377;
Component_0.Child_0.SliderLineHeight=7;
Child_0.width=200;
Child_0.height=100;
Child_0.Style.BorderThinkness=0;
ContainerStyle(Child_0.Style).Layout = 2;
var tab:corecom.control.Tab = null;
var content:corecom.control.TabContent = null;
tab = Child_0.CreateTab();
content = Child_0.FindContentByTab(tab);tab.width=50;
tab.height=30;
tab.MouseOverStyle.Width=50;
tab.MouseOverStyle.Height=30;
tab.MouseDownStyle.Width=50;
tab.MouseDownStyle.Height=30;
content.width=200;
content.height=70;
Child_0.TabHeight = 30;
Child_1.width=150;
Child_1.height=40;
Child_1.Style.BackgroundAlpha=0;
Child_1.Style.BorderThinkness=0;
Child_2.width=100;
Child_2.height=40;
Child_2.Style.BackgroundColor=65484;
Child_2.MouseOverStyle.Width=100;
Child_2.MouseOverStyle.Height=40;
Child_2.MouseOverStyle.BackgroundColor=6749952;
Child_2.MouseDownStyle.Width=100;
Child_2.MouseDownStyle.Height=40;
Child_2.MouseDownStyle.BackgroundColor=16711935;

}
}
}
