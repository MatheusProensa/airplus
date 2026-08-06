package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetFigureUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const PET_FIGURE_UPDATE:String = "RWPIUE_PET_FIGURE_UPDATE";
      
      private var _petId:int;
      
      private var _image:BitmapData;
      
      public function RoomWidgetPetFigureUpdateEvent(param1:int, param2:BitmapData, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPIUE_PET_FIGURE_UPDATE",param3,param4);
         _petId = param1;
         _image = param2;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
   }
}

