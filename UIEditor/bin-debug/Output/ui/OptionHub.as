package ui
{
import corecom.control.*;
 import corecom.control.asset.ControlAssetManager;

 import flash.display.Bitmap;
import flash.display.BitmapData; 
import corecom.control.style.*; 
public class OptionHub extends corecom.control.SimplePanel
{
public var Bag:SimpleButton = new SimpleButton();
public var Profile:SimpleButton = new SimpleButton();
public var Bag:SimpleButton = new SimpleButton();
public var Profile:SimpleButton = new SimpleButton();

public function OptionHub()
{
addChild(Bag);
Bag.x = 7;
Bag.y = 4;
addChild(Profile);
Profile.x = 51;
Profile.y = 4;
addChild(Bag);
Bag.x = 7;
Bag.y = 4;
addChild(Profile);
Profile.x = 51;
Profile.y = 4;

this.width=200;
this.height=40;
this.Style.BorderThinkness=0;
Bag.width=30;
Bag.height=30;
Bag.MouseOverStyle.Width=30;
Bag.MouseOverStyle.Height=30;
Bag.MouseOverStyle.BackgroundColor=13434624;
Bag.MouseDownStyle.Width=30;
Bag.MouseDownStyle.Height=30;
Bag.MouseDownStyle.BackgroundColor=16764057;
Profile.width=30;
Profile.height=30;
Profile.MouseOverStyle.Width=30;
Profile.MouseOverStyle.Height=30;
Profile.MouseDownStyle.Width=30;
Profile.MouseDownStyle.Height=30;
Bag.width=30;
Bag.height=30;
Bag.MouseOverStyle.Width=30;
Bag.MouseOverStyle.Height=30;
Bag.MouseOverStyle.BackgroundColor=13434624;
Bag.MouseDownStyle.Width=30;
Bag.MouseDownStyle.Height=30;
Bag.MouseDownStyle.BackgroundColor=16764057;
Profile.width=30;
Profile.height=30;
Profile.MouseOverStyle.Width=30;
Profile.MouseOverStyle.Height=30;
Profile.MouseDownStyle.Width=30;
Profile.MouseDownStyle.Height=30;

}
}
}
