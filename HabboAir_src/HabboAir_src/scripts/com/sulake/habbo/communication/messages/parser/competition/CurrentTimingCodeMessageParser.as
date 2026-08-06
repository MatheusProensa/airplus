package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CurrentTimingCodeMessageParser implements IMessageParser
   {
      private var _schedulingStr:String;
      
      private var _code:String;
      
      public function CurrentTimingCodeMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _schedulingStr = param1.readString();
         _code = param1.readString();
         return true;
      }
      
      public function get schedulingStr() : String
      {
         return _schedulingStr;
      }
      
      public function get code() : String
      {
         return _code;
      }
   }
}

