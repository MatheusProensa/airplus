package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   
   [SecureSWF(rename="true")]
   public class HabboUserBadgesMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _selectedBadges:Array;
      
      public function HabboUserBadgesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _userId = -1;
         _selectedBadges = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _userId = param1.readInteger();
         var _loc6_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            _loc5_ = param1.readInteger();
            _loc4_ = param1.readInteger();
            _selectedBadges.push(new SelectedBadgeData(_loc2_,_loc3_,_loc5_,_loc4_));
            _loc7_++;
         }
         return true;
      }
      
      public function get selectedBadges() : Array
      {
         return _selectedBadges;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

