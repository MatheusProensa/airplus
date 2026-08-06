package com.sulake.habbo.ui.widget.camera
{
   import flash.display.BitmapData;
   
   public class CameraSlotData
   {
      public var image:BitmapData;
      
      private var UnknownVarFromCameraSlotData_Date_1:Date;
      
      public var isEmpty:Boolean;
      
      public function CameraSlotData()
      {
         super();
      }
      
      public function setDate(param1:Date) : void
      {
         UnknownVarFromCameraSlotData_Date_1 = param1;
      }
      
      public function get dateString() : String
      {
         return UnknownVarFromCameraSlotData_Date_1.date + "/" + (UnknownVarFromCameraSlotData_Date_1.month + 1) + "/" + UnknownVarFromCameraSlotData_Date_1.getFullYear() + " " + UnknownVarFromCameraSlotData_Date_1.getHours() + ":" + addLeadingZero(UnknownVarFromCameraSlotData_Date_1.getMinutes());
      }
      
      private function addLeadingZero(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public function getDateTimestamp() : int
      {
         return UnknownVarFromCameraSlotData_Date_1.time;
      }
   }
}

