package com.sulake.habbo.room
{
   public class PetColorResult
   {
      private static const COLOR_TAGS:Array = ["Null","Black","White","Grey","Red","Orange","Pink","Green","Lime","Blue","Light-Blue","Dark-Blue","Yellow","Brown","Dark-Brown","Beige","Cyan","Purple","Gold"];
      
      private var _breed:int;
      
      private var _tag:String;
      
      private var _id:String;
      
      private var _primaryColor:int = 0;
      
      private var _secondaryColor:int = 0;
      
      private var _isMaster:Boolean = false;
      
      private var _layerTags:Array = [];
      
      public function PetColorResult(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean, param7:Array)
      {
         super();
         _primaryColor = param1 & 0xFFFFFF;
         _secondaryColor = param2 & 0xFFFFFF;
         _breed = param3;
         _tag = param4 > -1 && param4 < COLOR_TAGS.length ? COLOR_TAGS[param4] : "";
         _id = param5;
         _isMaster = param6;
         _layerTags = param7;
      }
      
      public function get primaryColor() : int
      {
         return _primaryColor;
      }
      
      public function get secondaryColor() : int
      {
         return _secondaryColor;
      }
      
      public function get breed() : int
      {
         return _breed;
      }
      
      public function get tag() : String
      {
         return _tag;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get isMaster() : Boolean
      {
         return _isMaster;
      }
      
      public function get layerTags() : Array
      {
         return _layerTags;
      }
   }
}

