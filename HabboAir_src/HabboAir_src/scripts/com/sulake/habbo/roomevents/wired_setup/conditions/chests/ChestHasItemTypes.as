package com.sulake.habbo.roomevents.wired_setup.conditions.chests
{
   import com.sulake.habbo.roomevents.wired_setup.conditions.ConditionCodes;
   
   public class ChestHasItemTypes extends ChestHasAmount
   {
      public function ChestHasItemTypes()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.CHEST_HAS_ITEM_TYPES;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.item_types";
         }
         return "wiredfurni.params.sources.furni.title.chests";
      }
      
      override public function mergedSelections() : Array
      {
         return [[2,0]];
      }
   }
}

