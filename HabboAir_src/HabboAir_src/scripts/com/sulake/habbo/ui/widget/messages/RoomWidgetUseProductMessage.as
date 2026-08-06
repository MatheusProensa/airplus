package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetUseProductMessage extends RoomWidgetMessage
   {
      public static const PET_PRODUCT:String = "RWUPM_PET_PRODUCT";
      
      public static const MONSTERPLANT_SEED:String = "RWUPM_MONSTERPLANT_SEED";
      
      private var _roomObjectId:int = 0;
      
      private var _petId:int = -1;
      
      public function RoomWidgetUseProductMessage(param1:String, param2:int, param3:int = -1)
      {
         super(param1);
         _roomObjectId = param2;
         _petId = param3;
      }
      
      public function get roomObjectId() : int
      {
         return _roomObjectId;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
   }
}

