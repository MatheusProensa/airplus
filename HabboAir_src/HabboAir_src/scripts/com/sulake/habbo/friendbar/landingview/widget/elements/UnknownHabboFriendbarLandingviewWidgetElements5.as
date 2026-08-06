package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class UnknownHabboFriendbarLandingviewWidgetElements5 implements IElementHandler
   {
      public function UnknownHabboFriendbarLandingviewWidgetElements5()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         param2.height = int(param3[1]);
      }
      
      public function refresh() : void
      {
      }
   }
}

