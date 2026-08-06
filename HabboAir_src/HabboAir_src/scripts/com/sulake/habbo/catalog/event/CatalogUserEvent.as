package com.sulake.habbo.catalog.event
{
   public class CatalogUserEvent extends CatalogEvent
   {
      private var _userId:int;
      
      private var _userName:String;
      
      public function CatalogUserEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _userId = param2;
         _userName = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

