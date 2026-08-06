package com.sulake.habbo.communication.messages.incoming.room.pets
{
   [SecureSWF(rename="true")]
   public class PetBreedingResultData
   {
      private var _stuffId:int;
      
      private var _classId:int;
      
      private var _productCode:String;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _rarityLevel:int;
      
      private var _hasMutation:Boolean;
      
      public function PetBreedingResultData(param1:int, param2:int, param3:String, param4:int, param5:String, param6:int, param7:Boolean)
      {
         super();
         _stuffId = param1;
         _classId = param2;
         _productCode = param3;
         _userId = param4;
         _userName = param5;
         _rarityLevel = param6;
         _hasMutation = param7;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function get hasMutation() : Boolean
      {
         return _hasMutation;
      }
   }
}

