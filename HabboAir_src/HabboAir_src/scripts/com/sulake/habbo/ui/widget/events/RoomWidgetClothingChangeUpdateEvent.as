package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetClothingChangeUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const SHOW_GENDER_SELECTION:String = "RWCCUE_SHOW_GENDER_SELECTION";
      
      public static const SHOW_CLOTHING_EDITOR:String = "RWCCUE_SHOW_CLOTHING_EDITOR";
      
      private var _objectId:int = -1;
      
      private var _objectCategory:int = -1;
      
      private var _roomId:int = -1;
      
      public function RoomWidgetClothingChangeUpdateEvent(param1:String, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _objectId = param2;
         _objectCategory = param3;
         _roomId = param4;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectCategory() : int
      {
         return _objectCategory;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

