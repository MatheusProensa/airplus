package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeLevelMessageData
   {
      private var _prizeLevelId:int;
      
      private var _probabilityDenominator:int;
      
      private var _prizes:Array;
      
      public function PrizeLevelMessageData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _prizeLevelId = param1.readInteger();
         _probabilityDenominator = param1.readInteger();
         _prizes = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _prizes.push(new PrizeMessageData(param1));
            _loc3_++;
         }
         _prizes.sortOn("productCode",1);
      }
      
      public function get prizeLevelId() : int
      {
         return _prizeLevelId;
      }
      
      public function get probabilityDenominator() : int
      {
         return _probabilityDenominator;
      }
      
      public function get prizes() : Array
      {
         return _prizes;
      }
   }
}

