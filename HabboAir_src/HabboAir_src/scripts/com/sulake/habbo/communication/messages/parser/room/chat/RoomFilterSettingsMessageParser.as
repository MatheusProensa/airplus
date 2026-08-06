package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomFilterSettingsMessageParser implements IMessageParser
   {
      private var _badWords:Array;
      
      public function RoomFilterSettingsMessageParser()
      {
         super();
      }
      
      public function get badWords() : Array
      {
         return _badWords;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _badWords = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _badWords.push(param1.readString());
            _loc3_++;
         }
         return false;
      }
   }
}

