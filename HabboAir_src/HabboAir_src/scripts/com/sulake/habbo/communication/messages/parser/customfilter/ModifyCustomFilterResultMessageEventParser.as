package com.sulake.habbo.communication.messages.parser.customfilter
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ModifyCustomFilterResultMessageEventParser implements IMessageParser
   {
      private var _result:int;
      
      private var _word:String;
      
      public function ModifyCustomFilterResultMessageEventParser()
      {
         super();
         _result = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readInteger();
         _word = param1.readString();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get word() : String
      {
         return _word;
      }
   }
}

