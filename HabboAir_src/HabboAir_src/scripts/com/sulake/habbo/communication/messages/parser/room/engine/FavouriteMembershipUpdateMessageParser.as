package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavouriteMembershipUpdateMessageParser implements IMessageParser
   {
      private var _roomIndex:int;
      
      private var _habboGroupId:int;
      
      private var _status:int;
      
      private var _habboGroupName:String;
      
      public function FavouriteMembershipUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomIndex = param1.readInteger();
         _habboGroupId = param1.readInteger();
         _status = param1.readInteger();
         _habboGroupName = param1.readString();
         return true;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get habboGroupId() : int
      {
         return _habboGroupId;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get habboGroupName() : String
      {
         return _habboGroupName;
      }
   }
}

