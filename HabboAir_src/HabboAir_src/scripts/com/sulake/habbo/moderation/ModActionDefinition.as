package com.sulake.habbo.moderation
{
   public class ModActionDefinition
   {
      public static const ALERT:int = 1;
      
      public static const MUTE:int = 2;
      
      public static const BAN:int = 3;
      
      public static const KICK:int = 4;
      
      public static const TRADING_LOCK:int = 5;
      
      public static const MESSAGE:int = 6;
      
      private var _actionId:int;
      
      private var _name:String;
      
      private var _actionType:int;
      
      private var _sanctionTypeId:int;
      
      private var _actionLengthHours:int;
      
      public function ModActionDefinition(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         _actionId = param1;
         _name = param2;
         _actionType = param3;
         _sanctionTypeId = param4;
         _actionLengthHours = param5;
      }
      
      public function get actionId() : int
      {
         return _actionId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get actionType() : int
      {
         return _actionType;
      }
      
      public function get sanctionTypeId() : int
      {
         return _sanctionTypeId;
      }
      
      public function get actionLengthHours() : int
      {
         return _actionLengthHours;
      }
   }
}

