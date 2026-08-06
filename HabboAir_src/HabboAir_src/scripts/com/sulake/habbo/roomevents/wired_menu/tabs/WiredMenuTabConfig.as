package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuTabConfig
   {
      private var _id:String;
      
      private var UnknownVarFromWiredMenuTabConfig_Class_1:Class;
      
      private var _isCreateImmediately:Boolean;
      
      private var _isReusable:Boolean;
      
      private var _isEnabled:Boolean;
      
      public function WiredMenuTabConfig(param1:String, param2:Class, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true)
      {
         super();
         _id = param1;
         UnknownVarFromWiredMenuTabConfig_Class_1 = param2;
         _isCreateImmediately = param3;
         _isReusable = param4;
         _isEnabled = param5;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get tabButtonName() : String
      {
         return "top_view_" + _id + "_button";
      }
      
      public function get containerName() : String
      {
         return _id + "_container";
      }
      
      public function get titleLocalizationKey() : String
      {
         return "wiredmenu." + _id + ".title";
      }
      
      public function createTab(param1:WiredMenuController, param2:IWindowController_1) : IWiredMenuDefaultTab
      {
         return new UnknownVarFromWiredMenuTabConfig_Class_1(param1,param2);
      }
      
      public function get isCreateImmediately() : Boolean
      {
         return _isCreateImmediately;
      }
      
      public function get isReusable() : Boolean
      {
         return _isReusable;
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
   }
}

