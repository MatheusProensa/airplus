package com.sulake.habbo.avatar.actions
{
   public class ActionType
   {
      private var _id:int;
      
      private var _value:int;
      
      private var _prevents:Array = [];
      
      private var _preventHeadTurn:Boolean = true;
      
      private var _isAnimated:Boolean = true;
      
      public function ActionType(param1:XML)
      {
         super();
         _id = parseInt(param1.@value);
         _value = parseInt(param1.@value);
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            _prevents = _loc3_.split(",");
         }
         _preventHeadTurn = String(param1.@preventheadturn) == "true";
         var _loc2_:String = String(param1.@animated);
         if(_loc2_ == "")
         {
            _isAnimated = true;
         }
         else
         {
            _isAnimated = _loc2_ == "true";
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get prevents() : Array
      {
         return _prevents;
      }
      
      public function get preventHeadTurn() : Boolean
      {
         return _preventHeadTurn;
      }
      
      public function get isAnimated() : Boolean
      {
         return _isAnimated;
      }
   }
}

