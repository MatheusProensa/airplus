package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class TitleElementHandler implements IElementHandler, UnknownIHabboFriendbarLandingviewInterfacesElements1
   {
      private var UnknownVarFromTitleElementHandler_Boolean_1:Boolean = false;
      
      public function TitleElementHandler()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         var _loc5_:IWindowController_1 = IWindowController_1(param2);
         var _loc6_:String = param3[1];
         UnknownVarFromTitleElementHandler_Boolean_1 = param3.length > 2 ? param3[2] == "true" : false;
         _loc5_.findChildByName("title_txt").caption = "${" + _loc6_ + "}";
         HabboLandingView.positionAfterAndStretch(_loc5_,"title_txt","hdr_line");
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return param1 || UnknownVarFromTitleElementHandler_Boolean_1;
      }
      
      public function refresh() : void
      {
      }
   }
}

