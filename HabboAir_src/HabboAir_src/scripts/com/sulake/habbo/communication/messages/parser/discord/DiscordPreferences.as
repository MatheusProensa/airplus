package com.sulake.habbo.communication.messages.parser.discord
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class DiscordPreferences
   {
      private var _version:int;
      
      private var _showHabbo:Boolean;
      
      private var _shareActivity:Boolean;
      
      private var _hideInHiddenRooms:Boolean;
      
      private var _allowJoining:Boolean;
      
      public function DiscordPreferences(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean)
      {
         super();
         _version = param1;
         _showHabbo = param2;
         _shareActivity = param3;
         _hideInHiddenRooms = param4;
         _allowJoining = param5;
      }
      
      public static function readFromData(param1:IMessageDataWrapper) : DiscordPreferences
      {
         var _loc5_:int = param1.readInteger();
         var _loc4_:Boolean = param1.readBoolean();
         var _loc3_:Boolean = param1.readBoolean();
         var _loc2_:Boolean = param1.readBoolean();
         var _loc6_:Boolean = param1.readBoolean();
         return new DiscordPreferences(_loc5_,_loc4_,_loc3_,_loc2_,_loc6_);
      }
      
      public function get version() : int
      {
         return _version;
      }
      
      public function get showHabbo() : Boolean
      {
         return _showHabbo;
      }
      
      public function get shareActivity() : Boolean
      {
         return _shareActivity;
      }
      
      public function get hideInHiddenRooms() : Boolean
      {
         return _hideInHiddenRooms;
      }
      
      public function get allowJoining() : Boolean
      {
         return _allowJoining;
      }
   }
}

