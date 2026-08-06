package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerPrizesMessageParser implements IMessageParser
   {
      private var _prizeLevels:Array;
      
      public function RecyclerPrizesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _prizeLevels = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _prizeLevels.push(new PrizeLevelMessageData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get prizeLevels() : Array
      {
         return _prizeLevels;
      }
   }
}

