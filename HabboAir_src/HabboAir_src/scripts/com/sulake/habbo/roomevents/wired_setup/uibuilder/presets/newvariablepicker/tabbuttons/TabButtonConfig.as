package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons
{
   public class TabButtonConfig
   {
      private var _tabId:int;
      
      private var _assetUri:String;
      
      private var _tooltipCaption:String;
      
      private var _filteredVariables:Function;
      
      public function TabButtonConfig(param1:int, param2:String, param3:String, param4:Function)
      {
         super();
         _tabId = param1;
         _assetUri = param2;
         _tooltipCaption = param3;
         _filteredVariables = param4;
      }
      
      public function get tabId() : int
      {
         return _tabId;
      }
      
      public function get assetUri() : String
      {
         return _assetUri;
      }
      
      public function get tooltipCaption() : String
      {
         return _tooltipCaption;
      }
      
      public function get filteredVariables() : Function
      {
         return _filteredVariables;
      }
   }
}

