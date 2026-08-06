package com.sulake.habbo.communication.messages.parser.customfilter
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class GetCustomFilterResultMessageEventParser implements IMessageParser
   {
      private var UnknownVarFromGetCustomFilterResultMessageEventParser_Array_1:Array = null;
      
      public function GetCustomFilterResultMessageEventParser()
      {
         super();
         UnknownVarFromGetCustomFilterResultMessageEventParser_Array_1 = [];
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         UnknownVarFromGetCustomFilterResultMessageEventParser_Array_1 = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            UnknownVarFromGetCustomFilterResultMessageEventParser_Array_1.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get words() : Array
      {
         return UnknownVarFromGetCustomFilterResultMessageEventParser_Array_1.slice();
      }
   }
}

