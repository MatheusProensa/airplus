package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FurniListRemoveMultipleParser implements IMessageParser
   {
      private var _stripIds:Vector.<int>;
      
      public function FurniListRemoveMultipleParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _stripIds = new Vector.<int>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _stripIds.push(param1.readInteger());
            _loc3_ += 1;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _stripIds = null;
         return true;
      }
      
      public function get stripIds() : Vector.<int>
      {
         return _stripIds;
      }
   }
}

