package com.sulake.habbo.friendbar.landingview.interfaces.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public interface IElementHandler
   {
      function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void;
      
      function refresh() : void;
   }
}

