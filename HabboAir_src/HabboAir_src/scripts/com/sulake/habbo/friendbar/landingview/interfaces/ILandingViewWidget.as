package com.sulake.habbo.friendbar.landingview.interfaces
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   
   public interface ILandingViewWidget extends IComponentInterfaceQueue
   {
      function initialize() : void;
      
      function refresh() : void;
      
      function get container() : IWindowModel;
   }
}

