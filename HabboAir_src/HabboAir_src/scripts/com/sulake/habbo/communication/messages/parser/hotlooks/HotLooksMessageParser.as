package com.sulake.habbo.communication.messages.parser.hotlooks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HotLooksMessageParser implements IMessageParser
   {
      private var _hotLooks:Array;
      
      public function HotLooksMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _hotLooks = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _hotLooks.push(new HotLookInfo(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get hotLooks() : Array
      {
         return _hotLooks;
      }
   }
}

