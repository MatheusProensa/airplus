package com.sulake.habbo.room.object.logic.furniture
{
   public class FurnitureRandomTeleportLogic extends FurnitureMultiStateLogic
   {
      public function FurnitureRandomTeleportLogic()
      {
         super();
      }
      
      override public function get contextMenu() : String
      {
         return "RANDOM_TELEPORT";
      }
   }
}

