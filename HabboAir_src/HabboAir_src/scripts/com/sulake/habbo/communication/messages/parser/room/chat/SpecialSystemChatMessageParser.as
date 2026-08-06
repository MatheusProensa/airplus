package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SpecialSystemChatMessageParser implements IMessageParser
   {
      private var _userIndex:int = 0;
      
      private var _specialSystemType:int = 0;
      
      public function SpecialSystemChatMessageParser()
      {
         super();
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function get specialSystemType() : int
      {
         return _specialSystemType;
      }
      
      public function flush() : Boolean
      {
         _userIndex = 0;
         _specialSystemType = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userIndex = param1.readInteger();
         _specialSystemType = param1.readInteger();
         return true;
      }
   }
}

