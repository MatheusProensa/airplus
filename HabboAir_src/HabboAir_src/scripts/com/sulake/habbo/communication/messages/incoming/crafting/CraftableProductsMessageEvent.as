package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftableProductsMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftableProductsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CraftableProductsMessageEvent(param1:Function)
      {
         super(param1,CraftableProductsMessageParser);
      }
      
      public function getParser() : CraftableProductsMessageParser
      {
         return _parser as CraftableProductsMessageParser;
      }
   }
}

