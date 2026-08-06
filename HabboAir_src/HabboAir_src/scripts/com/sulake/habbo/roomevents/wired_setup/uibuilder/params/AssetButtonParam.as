package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class AssetButtonParam
   {
      private var _assetName:String;
      
      private var _tooltip:String;
      
      private var _onClick:Function;
      
      private var _isFollowedBySplitter:Boolean;
      
      private var _alignRight:Boolean;
      
      public function AssetButtonParam(param1:String, param2:String, param3:Function, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         _assetName = param1;
         _tooltip = param2;
         _onClick = param3;
         _isFollowedBySplitter = param4;
         _alignRight = param5;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get tooltip() : String
      {
         return _tooltip;
      }
      
      public function get onClick() : Function
      {
         return _onClick;
      }
      
      public function get isFollowedBySplitter() : Boolean
      {
         return _isFollowedBySplitter;
      }
      
      public function get alignRight() : Boolean
      {
         return _alignRight;
      }
   }
}

