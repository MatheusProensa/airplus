package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipesAvailableMessageParser implements IMessageParser
   {
      private var _recipeComplete:Boolean;
      
      private var _count:int;
      
      public function CraftingRecipesAvailableMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _count = param1.readInteger();
         _recipeComplete = param1.readBoolean();
         return true;
      }
      
      public function flush() : Boolean
      {
         _count = 0;
         _recipeComplete = false;
         return true;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get recipeComplete() : Boolean
      {
         return _recipeComplete;
      }
   }
}

