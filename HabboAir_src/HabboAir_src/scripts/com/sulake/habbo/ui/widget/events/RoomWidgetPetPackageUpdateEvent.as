package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetPackageUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetPetPackageUpdateEvent_String_1:String = "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED";
      
      public static const OPEN_PET_PACKAGE_RESULT:String = "RWOPPUE_OPEN_PET_PACKAGE_RESULT";
      
      public static const OPEN_PET_PACKAGE_UPDATE_PET_IMAGE:String = "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE";
      
      private var _objectId:int = -1;
      
      private var _typeId:int = -1;
      
      private var _image:BitmapData = null;
      
      private var _nameValidationStatus:int = 0;
      
      private var _nameValidationInfo:String = null;
      
      public function RoomWidgetPetPackageUpdateEvent(param1:String, param2:int, param3:BitmapData, param4:int, param5:String, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         _objectId = param2;
         _image = param3;
         _nameValidationStatus = param4;
         _nameValidationInfo = param5;
         _typeId = param6;
      }
      
      public function get nameValidationStatus() : int
      {
         return _nameValidationStatus;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
   }
}

