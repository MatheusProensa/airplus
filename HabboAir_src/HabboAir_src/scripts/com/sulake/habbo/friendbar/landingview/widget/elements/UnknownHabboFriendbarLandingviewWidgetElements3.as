package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class UnknownHabboFriendbarLandingviewWidgetElements3 implements IElementHandler
   {
      public function UnknownHabboFriendbarLandingviewWidgetElements3()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         var _loc8_:String = param3[2];
         var _loc5_:IWindowController_1 = IWindowController_1(param2);
         _loc5_.findChildByName("badge_desc").caption = "";
         var _loc6_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc5_.findChildByName("badge_image"));
         var _loc7_:String = "${image.library.url}album1584/" + param3[1] + ".png";
         Logger.log("IMAGE: " + _loc7_);
         _loc6_.assetUri = _loc7_;
      }
      
      public function refresh() : void
      {
      }
   }
}

