package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotReceivedMessageParser implements IMessageParser
   {
      private var _boughtAsGift:Boolean;
      
      private var _item:BotData;
      
      public function BotReceivedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _boughtAsGift = param1.readBoolean();
         _item = new BotData(param1);
         return true;
      }
      
      public function get boughtAsGift() : Boolean
      {
         return _boughtAsGift;
      }
      
      public function get item() : BotData
      {
         return _item;
      }
   }
}

