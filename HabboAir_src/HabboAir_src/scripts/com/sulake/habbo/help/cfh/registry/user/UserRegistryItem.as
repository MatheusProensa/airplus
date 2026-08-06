package com.sulake.habbo.help.cfh.registry.user
{
   public class UserRegistryItem
   {
      private var _userId:int;
      
      private var _userName:String = "";
      
      private var _roomName:String = "";
      
      private var _figure:String = "";
      
      private var _roomId:int;
      
      public function UserRegistryItem(param1:int, param2:String, param3:String, param4:int, param5:String = "")
      {
         super();
         _userId = param1;
         _userName = param2;
         _roomId = param4;
         _roomName = param5;
         _figure = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

