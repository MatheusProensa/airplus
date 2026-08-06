package com.sulake.habbo.communication.messages.incoming.crafting
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.CraftingRecipesAvailableMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipesAvailableMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CraftingRecipesAvailableMessageEvent(param1:Function)
      {
         super(param1,CraftingRecipesAvailableMessageParser);
      }
      
      public function getParser() : CraftingRecipesAvailableMessageParser
      {
         return _parser as CraftingRecipesAvailableMessageParser;
      }
   }
}

