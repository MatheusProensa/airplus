package com.sulake.habbo.catalog.offers
{
   public class OfferReward
   {
      private var _name:String;
      
      private var _contentType:String;
      
      private var _classId:int;
      
      public function OfferReward(param1:String, param2:String, param3:int)
      {
         super();
         _name = param1;
         _contentType = param2;
         _classId = param3;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get contentType() : String
      {
         return _contentType;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
   }
}

