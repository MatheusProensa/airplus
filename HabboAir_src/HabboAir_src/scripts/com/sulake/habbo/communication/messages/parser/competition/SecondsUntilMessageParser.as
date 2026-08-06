package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SecondsUntilMessageParser implements IMessageParser
   {
      private var _timeStr:String;
      
      private var _secondsUntil:int;
      
      public function SecondsUntilMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _timeStr = param1.readString();
         _secondsUntil = param1.readInteger();
         return true;
      }
      
      public function get timeStr() : String
      {
         return _timeStr;
      }
      
      public function get secondsUntil() : int
      {
         return _secondsUntil;
      }
   }
}

