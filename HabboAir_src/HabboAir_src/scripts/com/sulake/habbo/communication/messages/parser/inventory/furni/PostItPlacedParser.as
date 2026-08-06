package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PostItPlacedParser implements IMessageParser
   {
      private var _id:int;
      
      private var _itemsLeft:int;
      
      public function PostItPlacedParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _id = param1.readInteger();
         _itemsLeft = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get itemsLeft() : int
      {
         return _itemsLeft;
      }
   }
}

