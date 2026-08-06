package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RecyclerFinishedMessageParser implements IMessageParser
   {
      private var _recyclerFinishedStatus:int = -1;
      
      private var _prizeId:int = 0;
      
      public function RecyclerFinishedMessageParser()
      {
         super();
      }
      
      public function get recyclerFinishedStatus() : int
      {
         return _recyclerFinishedStatus;
      }
      
      public function get prizeId() : int
      {
         return _prizeId;
      }
      
      public function flush() : Boolean
      {
         _recyclerFinishedStatus = -1;
         _prizeId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _recyclerFinishedStatus = param1.readInteger();
         _prizeId = param1.readInteger();
         return true;
      }
   }
}

