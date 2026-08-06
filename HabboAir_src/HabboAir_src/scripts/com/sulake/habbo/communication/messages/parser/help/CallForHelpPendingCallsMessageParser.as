package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpPendingCallsMessageParser implements IMessageParser
   {
      private var _callArray:Array = [];
      
      public function CallForHelpPendingCallsMessageParser()
      {
         super();
      }
      
      public function get callArray() : Array
      {
         return _callArray;
      }
      
      public function get callCount() : int
      {
         return _callArray.length;
      }
      
      public function flush() : Boolean
      {
         _callArray = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:Object = null;
         _callArray = [];
         var _loc3_:int = param1.readInteger();
         while(_loc4_ < _loc3_)
         {
            _loc2_ = {};
            _loc2_.callId = param1.readString();
            _loc2_.timeStamp = param1.readString();
            _loc2_.message = param1.readString();
            _callArray.push(_loc2_);
            _loc4_++;
         }
         return true;
      }
   }
}

