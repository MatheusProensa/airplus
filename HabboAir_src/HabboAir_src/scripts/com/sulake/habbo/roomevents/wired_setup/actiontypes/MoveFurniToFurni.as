package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class MoveFurniToFurni extends DefaultActionType
   {
      public function MoveFurniToFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_FURNI_TO_FURNI;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv." + param1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

