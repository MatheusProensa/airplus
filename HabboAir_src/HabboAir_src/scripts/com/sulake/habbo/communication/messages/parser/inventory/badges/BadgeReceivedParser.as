package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BadgeReceivedParser implements IMessageParser
   {
      private var _badgeId:int;
      
      private var _badgeCode:String;
      
      private var _ownerCount:int;
      
      private var _badgeRarityId:int;
      
      public function BadgeReceivedParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _badgeId = param1.readInteger();
         _badgeCode = param1.readString();
         _ownerCount = param1.readInteger();
         _badgeRarityId = param1.readInteger();
         return true;
      }
      
      public function get badgeId() : int
      {
         return _badgeId;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get ownerCount() : int
      {
         return _ownerCount;
      }
      
      public function get badgeRarityId() : int
      {
         return _badgeRarityId;
      }
   }
}

