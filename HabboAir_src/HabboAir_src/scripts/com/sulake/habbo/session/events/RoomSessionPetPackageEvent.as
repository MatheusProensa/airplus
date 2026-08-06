package com.sulake.habbo.session.events
{
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetPackageEvent extends RoomSessionEvent
   {
      public static const ROOM_SESSION_OPEN_PET_PACKAGE_REQUESTED:String = "RSOPPE_OPEN_PET_PACKAGE_REQUESTED";
      
      public static const ROOM_SESSION_OPEN_PET_PACKAGE_RESULT:String = "RSOPPE_OPEN_PET_PACKAGE_RESULT";
      
      private var _objectId:int = -1;
      
      private var _figureData:PetFigureData;
      
      private var _nameValidationStatus:int = 0;
      
      private var _nameValidationInfo:String = null;
      
      public function RoomSessionPetPackageEvent(param1:String, param2:IRoomSession, param3:int, param4:PetFigureData, param5:int, param6:String, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param7,param8);
         _objectId = param3;
         _figureData = param4;
         _nameValidationStatus = param5;
         _nameValidationInfo = param6;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get figureData() : PetFigureData
      {
         return _figureData;
      }
      
      public function get nameValidationStatus() : int
      {
         return _nameValidationStatus;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
   }
}

