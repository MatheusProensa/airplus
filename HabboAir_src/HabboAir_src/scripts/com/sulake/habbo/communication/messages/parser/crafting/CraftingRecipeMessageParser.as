package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingRecipeMessageParser implements IMessageParser
   {
      private var _ingredients:Vector.<OutgoingIngredient> = new Vector.<OutgoingIngredient>(0);
      
      public function CraftingRecipeMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _ingredients.push(new OutgoingIngredient(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _ingredients = new Vector.<OutgoingIngredient>(0);
         return true;
      }
      
      public function get ingredients() : Vector.<OutgoingIngredient>
      {
         return _ingredients;
      }
   }
}

