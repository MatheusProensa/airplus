package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RequestSpamWallPostItMessageParser implements IMessageParser
   {
      private var _itemId:int;
      
      private var _location:String;
      
      public function RequestSpamWallPostItMessageParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get location() : String
      {
         return _location;
      }
      
      public function flush() : Boolean
      {
         _itemId = -1;
         _location = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _itemId = param1.readInteger();
         _location = param1.readString();
         return true;
      }
   }
}

